class ProjectsController < ApplicationController
  before_action :load_project, except: %i[index new create]

  def index
    @q = Project.ransack(params[:q])
    @projects = @q.result(distinct: true).order(:status, :title).page(params[:page])
  end

  def show; end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(form_params)

    if @project.save
      redirect_to project_path(@project), notice: 'Project created'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @project.update(form_params)
      redirect_to project_path(@project), notice: 'Project updated'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_path, notice: 'Project deleted'
  end

  def activity
    progress_updates = ProgressUpdate.where(indicator: @project.indicators)
    @audits = Audited::Audit.includes(:user).where(auditable: @project).or(
      Audited::Audit.includes(:user).where(associated: [@project] + @project.indicators + progress_updates)
    ).order(created_at: :desc).page(params[:page])
  end

  def timeline
    @q = Project.joins(:goals).group("projects.id", "goals.id", "goals.title")
      .select("goals.id AS goal_id", "goals.title AS goal_title", "projects.*").ransack(params[:q])
    @projects = @q.result(distinct: true)

    @groups = @projects.pluck('goals.id', 'goals.title').map do |id, title|
      { id: id, content: helpers.link_to(title, goal_path(id)) }
    end.to_json
  end

  private

  def form_params
    params.require(:project).permit(
      :context, :end_date, :expectations, :objective, :start_date, :status,
      :title, :estimated_cost, :scoping_start_date, :ambition, :phase,
      :geography, :impact_statement, :impact_type, goal_ids: [], tag_ids: []
    )
  end

  def load_project
    @project = Project.find_puid(params[:id] || params[:project_id])
  end
end
