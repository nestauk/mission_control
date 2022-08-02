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

  private

  def to_var(targetable)
    targetable.class.to_s.underscore
  end
end
