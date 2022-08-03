class GoalsController < ApplicationController
  before_action :load_goal, except: %i[index new create]

  def index
    @q = Goal.ransack(params[:q])
    @goals = @q.result(distinct: true).page(params[:page])
  end

  def show; end

  def new
    @goal = Goal.new
  end

  def create
    @goal = Goal.new(form_params)

    if @goal.save
      redirect_to goal_path(@goal), notice: 'Goal created'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @goal.update(form_params)
      redirect_to goal_path(@goal), notice: 'Goal updated'
    else
      render :edit
    end
  end

  def objectives; end

  private

  def form_params
    params.require(:goal).permit(:context, :status, :title, :shortname, objective_ids: [])
  end

  def load_goal
    @goal = Goal.find_by(id: params[:id] || params[:goal_id])
  end
end
