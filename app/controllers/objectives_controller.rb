class ObjectivesController < ApplicationController
  before_action :load_objective, except: %i[index new create]

  def index
    @q = Objective.ransack(params[:q])
    @objectives = @q.result(distinct: true).page(params[:page])
  end

  def show; end

  def new
    @objective = Objective.new
  end

  def create
    @objective = Objective.new(form_params)

    if @objective.save
      redirect_to objective_path(@objective), notice: 'Objective created'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @objective.update(form_params)
      redirect_to objective_path(@objective), notice: 'Objective updated'
    else
      render :edit
    end
  end

  private

  def form_params
    params.require(:objective).permit(
      :context, :end_date, :expectations, :objective, :start_date, :status,
      :title, goal_ids: []
    )
  end

  def load_objective
    @objective = Objective.find_by(id: params[:id])
  end
end
