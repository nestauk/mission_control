class Indicator < ApplicationRecord
  belongs_to :targetable, polymorphic: true

  enum last_progress_update_status: { on_track: 0, a_little_shaky: 1, struggling: 2 }
  enum status: { planning: 0, active: 1, complete: 2, on_hold: 3 }
  enum update_frequency: { never: 0, weekly: 1, monthly: 2, quarterly: 3 }
end
