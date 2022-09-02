class Indicator < ApplicationRecord
  belongs_to :impact_type, optional: true
  belongs_to :impact_rigour, optional: true
  belongs_to :impact_level, optional: true

  belongs_to :targetable, polymorphic: true

  has_many :progress_updates, dependent: :destroy

  enum last_progress_update_status: { on_track: 0, at_risk: 1, off_track: 2 }

  validates :title, presence: true
  validates :impact_type_id, :impact_rigour_id, :impact_level_id, presence: true, if: :is_impact_indicator

  has_rich_text :description

  before_validation { strip_whitespace(%i[title]) }

  def progress
    return if target_value.blank? || last_progress_update_value.nil?

    (last_progress_update_value / target_value) * 100
  end
end
