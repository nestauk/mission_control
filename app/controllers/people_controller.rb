class PeopleController < ApplicationController
  before_action :load_person, except: %i[index new create]

  def index
    @q = Person.eager_load(:contacts, :organisations).ransack(params[:q])
    @people = @q.result(distinct: true).order(:first_name, :last_name).page(params[:page])
  end

  def show
    if params[:q]
      @projects = @person.projects
        .select("memberships.role AS membership_role", "projects.*")
        .ransack(params[:q]).result(distinct: true)
      @groups = @projects.pluck("memberships.role").map do |role|
        { id: Membership.roles[role], content: role.humanize }
      end.to_json
    else
      @projects = @person.projects.where(status: [:planning, :committed])
        .select("memberships.role AS membership_role", "projects.*")
      @groups = @projects.pluck("memberships.role").map do |role|
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
      :first_name,
      :last_name,
      :pronouns,
      :notes,
      contacts_attributes: %i[_destroy id organisation_id position email phone status]
    )
  end

  def load_person
    @person = Person.find_by(id: params[:id])
  end
end
