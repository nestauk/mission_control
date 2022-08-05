class LinksController < ApplicationController
  before_action :load_linkable

  def index; end

  def new
    @link = @linkable.links.new
  end

  def create
    @link = @linkable.links.new(form_params)

    if @link.save
      redirect_to helpers.linkable_path(@linkable), notice: 'Link created'
    else
      render :new
    end
  end

  def edit
    @link = Link.find_by(id: params[:id])
  end

  def update
    @link = Link.find_by(id: params[:id])

    if @link.update(form_params)
      redirect_to helpers.linkable_path(@linkable), notice: 'Link updated'
    else
      render :edit
    end
  end

  def destroy
    @link = Link.find_by(id: params[:id])
    @link.destroy
    redirect_to helpers.linkable_path(@linkable), notice: 'Link deleted.'
  end

  private

  def form_params
    params.require(:link).permit(:url, :name)
  end

  def load_linkable
    @linkable = Goal.find_by(id: params[:goal_id]) || Project.find_by(id: params[:project_id])
    @project = @linkable
    @goal = @linkable
    redirect_back fallback_location: root_path, alert: 'Project or Goal not found' if @linkable.nil?
  end
end
