class Indicator < ApplicationRecord
  belongs_to :targetable, polymorphic: true

  has_many :progress_updates, dependent: :destroy

  enum last_progress_update_status: { on_track: 0, a_little_shaky: 1, struggling: 2 }
  enum status: { planning: 0, active: 1, complete: 2, on_hold: 3 }
  enum update_frequency: { never: 0, weekly: 1, monthly: 2, quarterly: 3 }

  before_validation { strip_whitespace(%i[title]) }

  def progress
    return if target_value.blank? || last_progress_update_value.nil?

    (last_progress_update_value / target_value) * 100
  end

  def requires_update?
    return false if status != 'active' || update_frequency == 'never'

    return false if Date.today < start_date

    return false if Date.today > end_date if end_date

    last_progress_update_date.nil? || last_progress_update_date < Date.today.send("beginning_of_#{update_frequency.slice(0..-3)}")
  end
end
