class IndicatorsController < ApplicationController
  before_action :load_targetable

  def show
    @indicator = Indicator.find_by(id: params[:id])
  end

  def new
    @indicator = @targetable.indicators.new
  end

  def create
    @indicator = @targetable.indicators.new(form_params)

    if @indicator.save
      redirect_to helpers.targetable_path(@targetable), notice: 'Progress indicator created'
    else
      render :new
    end
  end

  def edit
    @indicator = Indicator.find_by(id: params[:id])
  end

  def update
    @indicator = Indicator.find_by(id: params[:id])

    if @indicator.update(form_params)
      redirect_to helpers.targetable_indicator_path(@targetable, @indicator), notice: 'Progress indicator updated'
    else
      render :edit
    end
  end

  def destroy
    @indicator = Indicator.find_by(id: params[:id])
    @indicator.destroy
    redirect_to helpers.targetable_indicators_path(@targetable), notice: 'Progress indicator deleted'
  end

  private

  def form_params
    params.require(:indicator).permit(
      :end_date, :start_date, :status, :target_value, :title, :unit, :update_frequency
    )
  end

  def load_targetable
    @targetable = Goal.find_by(id: params[:goal_id]) || Objective.find_by(id: params[:objective_id])
    @objective = @targetable
    @goal = @targetable
    redirect_back fallback_location: root_path, alert: 'Objective or Goal not found' if @targetable.nil?
  end
end
