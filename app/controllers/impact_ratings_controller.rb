class ImpactRatingsController < ApplicationController
  before_action :load_impactable

  def new
    @impact_rating = ImpactRating.new(impactable: @impactable)
  end

  def create
    @impact_rating = ImpactRating.new(form_params)
    @impact_rating.impactable = @impactable

    if @impact_rating.save
      redirect_to helpers.impactable_path(@impactable), notice: 'Impact rating created'
    else
      render :new
    end
  end

  def edit
    @impact_rating = ImpactRating.find_by(id: params[:id])
  end

  def update
    @impact_rating = ImpactRating.find_by(id: params[:id])

    if @impact_rating.update(form_params)
      redirect_to helpers.impactable_path(@impactable), notice: 'Impact rating updated'
    else
      render :edit
    end
  end

  private

  def form_params
    params.require(:impact_rating).permit(
      :hypothesis, :confidence, :audience_description, :no_people_reached,
      :potential_reach, :scale_likelihood, :contribution_type
    )
  end

  def load_impactable
    @impactable = Goal.find_by(id: params[:goal_id]) || Project.find_by(id: params[:project_id])
    @project = @impactable
    @goal = @impactable
    redirect_back fallback_location: root_path, alert: 'Project or Goal not found' if @impactable.nil?
  end
end
