class ProgressUpdatesController < ApplicationController
  before_action :load_indicator, :load_targetable

  def new
    @progress_update = @indicator.progress_updates.new
  end

  def create
    @progress_update = @indicator.progress_updates.new(form_params)

    if @progress_update.save
      redirect_to helpers.targetable_indicator_path(@targetable, @indicator), notice: 'Progress update added'
    else
      render :new
    end
  end

  def edit
    @progress_update = ProgressUpdate.find(params[:id])
  end

  def update
    @progress_update = ProgressUpdate.find(params[:id])

    if @progress_update.update(form_params)
      redirect_to helpers.targetable_indicator_path(@targetable, @indicator), notice: 'Progress update updated'
    else
      render :edit
    end
  end

  def destroy
    progress_update = ProgressUpdate.find(params[:id])
    progress_update.destroy
    redirect_to helpers.targetable_indicator_path(@targetable, @indicator), notice: 'Progress update deleted'
  end

  private

  def form_params
    params.require(:progress_update).permit(
      :content, :status, :value, :date
    ).with_defaults(author: current_user.contact)
  end

  def load_indicator
    @indicator = Indicator.find(params[:indicator_id])
    return redirect_to root_path, alert: 'Not found' if @indicator.nil?
  end

  def load_targetable
    @targetable = @indicator.targetable
  end
end
