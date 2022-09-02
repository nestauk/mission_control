class ImpactOptionsController < ApplicationController
  def impact_rigours
    render json: ImpactRigour.select(:id, :title).where(impact_type_id: params[:id]).order(:rating)
  end

  def impact_levels
    render json: ImpactLevel.select(:id, :title).where(impact_rigour_id: params[:id]).order(:rating)
  end
end
