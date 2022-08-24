class PeopleController < ApplicationController
  before_action :load_person, except: %i[index new create]

  def index
    @q = Person.eager_load(:contacts, :organisations).ransack(params[:q])
    @people = @q.result(distinct: true).order(:first_name, :last_name).page(params[:page])
  end

  def show
    @capacity = ActiveRecord::Base.connection.execute(
      "SELECT DATE_PART('week', p.week) AS week, sum(m.avg_time_per_week)
      FROM (
          SELECT * FROM projects, generate_series(start_date, end_date, '1 week') AS week
      ) AS p
      JOIN memberships AS m ON m.memberable_id=p.id AND memberable_type='Project'
      WHERE m.memberable_id IN (#{@person.project_ids.join(',')})
      GROUP BY p.week
      ORDER BY p.week"
    ).to_json

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
    @person = Person.find_by(id: params[:id])
  end
end
