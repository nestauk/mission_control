class PeopleController < ApplicationController
  before_action :load_person, except: %i[index new create]

  def index
    @q = Person.eager_load(:contacts, :organisations).ransack(params[:q])
    @people = @q.result(distinct: true).order(:first_name, :last_name).page(params[:page])
  end

  def capacity
    render json: @capacity = ActiveRecord::Base.connection.execute(
      "SELECT date_trunc('week', p.week)::date AS week_of, sum(m.avg_time_per_week) AS sum
      FROM (
        SELECT * FROM projects, generate_series(start_date, end_date, '1 week') AS week
        WHERE status in (0, 1)
      ) AS p
      JOIN memberships AS m ON m.memberable_id=p.id AND memberable_type='Project'
      WHERE m.contact_id = #{@person.id}
      GROUP BY 1
      ORDER BY 1"
      ).group_by_week(week_start: :monday, series: true) { |a| a["week_of"].to_datetime }
        .map { |date, array| [ date, array.empty? ? 0 : array[0]["sum"] ] }
        .to_h
  end

  def capacity_index
    # TODO: refactor
    @q = Project.ransack(params[:q])
    @projects_search = @q.result(distinct: true)

    @data = ActiveRecord::Base.connection.execute(
      "SELECT date_trunc('week', p.week)::date AS week_of, p.title, p.public_uid, people.slug, m.avg_time_per_week
      FROM (
        SELECT * FROM projects, generate_series(start_date, end_date, '1 week') AS week
        WHERE status in (#{params[:q][:status_in].reject(&:empty?).join(', ')})
      ) AS p
      JOIN memberships AS m ON m.memberable_id=p.id AND memberable_type='Project'
      JOIN people ON people.id = m.contact_id
      WHERE m.contact_id IN (#{params[:q][:memberships_contact_id_in].reject(&:empty?).join(', ')})"
      )
      .group_by_week(week_start: :monday, series: true) { |a| a["week_of"].to_datetime }

    @weeks = []
    @by_person = {}
    @by_project = {}
    @people = Set.new
    @projects = Set.new

    @data.each do |date, array|
      @weeks << date

      array.each do |h|
        @people << h['slug']
        @projects << h['title']
      end
    end

    @people.sort.each do |person|
      @weeks.each do |week|
        @by_person[person] = [] unless @by_person[person]
        @by_person[person] << @data[week]
      end
    end

    @projects.sort.each do |project|
      @weeks.each do |week|
        @by_project[project] = {} unless @by_project[project]

        @people.each do |person|
          @by_project[project][person] = [] unless @by_project[project][person]
          @by_project[project][person] << @by_person[person]
        end
      end
    end
  end

  def show
    if params[:q]
      @projects = @person.projects
        .select("memberships.role AS membership_role", "projects.*")
        .ransack(params[:q]).result(distinct: true)
      @groups = @projects.distinct.pluck("memberships.role").map do |role|
        { id: Membership.roles[role], content: role.humanize }
      end.to_json
    else
      @projects = @person.projects.where(status: [:scoping, :committed])
        .select("memberships.role AS membership_role", "projects.*")
      @groups = @projects.distinct.pluck("memberships.role").map do |role|
        { id: Membership.roles[role], content: role.humanize }
      end.to_json
    end
  end

  def new
    @person = Person.new
    @person.contacts.build(organisation_id: params[:organisation])
  end

  def create
    @person = Person.new(form_params)

    if @person.save
      redirect_to @person, notice: 'Person created'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @person.update(form_params)
      redirect_to @person, notice: 'Person updated'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @person.destroy
    redirect_to people_path, notice: 'Person deleted'
  end

  private

  def form_params
    params.require(:person).permit(
      :first_name, :last_name, :pronouns,
      contacts_attributes: %i[_destroy id organisation_id position email status]
    )
  end

  def load_person
    @person = Person.find_by(slug: params[:id])
  end
end
