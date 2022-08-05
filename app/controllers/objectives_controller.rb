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

  def timeline
    @q = Objective.joins(:goals).group("objectives.id", "goals.id", "goals.title")
      .select("goals.id AS goal_id", "goals.title AS goal_title", "objectives.*").ransack(params[:q])
    @objectives = @q.result(distinct: true)
    @groups = Goal.pluck(:id, :title).map do |id, title|
      { id: id, content: helpers.link_to(title, goal_path(id)) }
    end.to_json
  end

  private

  def form_params
    params.require(:objective).permit(
      :context, :end_date, :expectations, :objective, :start_date, :status,
      :title, :estimated_cost, goal_ids: [], tag_ids: []
    )
  end

  def load_objective
    @objective = Objective.find_by(id: params[:id])
  end
end
