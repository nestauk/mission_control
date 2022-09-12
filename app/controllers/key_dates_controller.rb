class KeyDatesController < ApplicationController
  before_action :load_project
  before_action :load_key_date, only: %i[edit update destroy]

  def new
    @date = @project.key_dates.new
  end

  def create
    @date = @project.key_dates.new(form_params)

    if @date.save
      redirect_to project_path(@project), notice: 'Date created'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @date.update(form_params)
      redirect_to project_path(@project), notice: 'Date updated'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @date.destroy
    redirect_to project_path(@project), notice: 'Date deleted'
  end

  private

  def form_params
    params.require(:key_date).permit(:date, :title)
  end

  def load_project
    @project = Project.find_puid(params[:project_id])
  end

  def load_key_date
    @date = KeyDate.find_by(id: params[:id])
  end
end
