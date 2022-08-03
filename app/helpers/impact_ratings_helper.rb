module ImpactRatingsHelper
  def impactable_path(impactable, opts = {})
    send("#{to_var(impactable)}_path", impactable, opts)
  end

  def impactable_impact_ratings_path(impactable)
    send("#{to_var(impactable)}_impact_ratings_path", impactable)
  end

  def impactable_impact_rating_path(impactable, impact_rating)
    send("#{to_var(impactable)}_impact_rating_path", impactable, impact_rating)
  end

  def new_impactable_impact_rating_path(impactable)
    send("new_#{to_var(impactable)}_impact_rating_path", impactable)
  end

  def edit_impactable_impact_rating_path(impactable, impact_rating)
    send("edit_#{to_var(impactable)}_impact_rating_path", impactable, impact_rating)
  end

  def score_color(score)
    {
      1 => "text-red-700",
      2 => "text-rose-700",
      3 => "text-amber-700",
      4 => "text-yellow-700",
      5 => "text-lime-700"
    }[score.round]
  end

  private

  def to_var(impactable)
    impactable.class.to_s.underscore
  end
end
