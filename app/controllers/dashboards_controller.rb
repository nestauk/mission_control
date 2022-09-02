class DashboardsController < ApplicationController
  def impact
    @indicators = Indicator.where(is_impact_indicator: true, targetable_type: "Project").order(:targetable_id)
  end
end
