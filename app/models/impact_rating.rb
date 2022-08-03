class ImpactRating < ApplicationRecord
  CONFIDENCE_SCALE = [
    ['1 - Judgement', 1],
    ['2 - Judgement + Correlational data', 2],
    ['3 - Correlational data + Quasi-experiment', 3],
    ['4 - Quasi-experiment', 4],
    ['5 - RCT', 5]
  ]

  belongs_to :impactable, polymorphic: true

  enum contribution_type: { direct: 0, indirect: 1 }

  has_rich_text :description

  before_save :compute_score

  private

  def compute_score
    self.score = (confidence + scale_likelihood_score).to_f / 2
  end

  def scale_likelihood_score
    if scale_likelihood > 80
      5
    elsif scale_likelihood > 60
      4
    elsif scale_likelihood > 40
      3
    elsif scale_likelihood > 20
      2
    else
      1
    end
  end
end
