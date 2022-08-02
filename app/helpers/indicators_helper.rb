module IndicatorsHelper
  def targetable_path(targetable, opts = {})
    send("#{to_var(targetable)}_path", targetable, opts)
  end

  def targetable_indicators_path(targetable, opts = {})
    send("#{to_var(targetable)}_indicators_path", targetable, opts)
  end

  def targetable_indicator_path(targetable, indicator)
    send("#{to_var(targetable)}_indicator_path", targetable, indicator)
  end

  def new_targetable_indicator_path(targetable)
    send("new_#{to_var(targetable)}_indicator_path", targetable)
  end

  def edit_targetable_indicator_path(targetable, indicator)
    send("edit_#{to_var(targetable)}_indicator_path", targetable, indicator)
  end

  def bg_status(status)
    case status
    when "on_track"
      "bg_on_track"
    when "at_risk"
      "bg_at_risk"
    when "off_track"
      "bg_off_track"
    end
  end

  def status_with_icon(status)
    case status
    when "on_track"
      "on_track_with_icon"
    when "at_risk"
      "at_risk_with_icon"
    when "off_track"
      "off_track_with_icon"
    end
  end

  private

  def to_var(targetable)
    targetable.class.to_s.underscore
  end
end
