class MembershipsController < ApplicationController
  before_action :load_memberable

  def index; end

  def new
    @membership = @memberable.memberships.new
  end

  def create
    # TODO: prevent duplicate memberships
    @membership = @memberable.memberships.new(form_params)

    if @membership.save
      redirect_to helpers.memberable_memberships_path(@memberable), notice: 'Membership created'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @membership = Membership.find_by(id: params[:id])
  end

  def update
    @membership = Membership.find_by(id: params[:id])

    if @membership.update(form_params)
      redirect_to helpers.memberable_memberships_path(@memberable), notice: 'Membership updated'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @membership = Membership.find_by(id: params[:id])
    @membership.destroy
    redirect_to helpers.memberable_memberships_path(@memberable), notice: 'Membership deleted.'
  end

  private

  def form_params
    params.require(:membership).permit(
      :contact_id, :role, :description, :avg_weekly_time_percentage
    )
  end

  def load_memberable
    @memberable = Goal.find_by(id: params[:goal_id]) || Project.find_by(id: params[:project_id])
    @project = @memberable
    @goal = @memberable
    redirect_back fallback_location: root_path, alert: 'Project or Goal not found' if @memberable.nil?
  end
end
