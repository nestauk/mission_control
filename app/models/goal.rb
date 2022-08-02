class Goal < ApplicationRecord
  has_many :indicators, as: :targetable, dependent: :destroy

  has_many :contributions, dependent: :destroy
  has_many :objectives, through: :contributions

  enum status: { planning: 0, active: 1, complete: 2, on_hold: 3 }

  has_rich_text :context
end
