class Goal < ApplicationRecord
  has_many :indicators, as: :targetable, dependent: :destroy

  has_many :contributions, dependent: :destroy
  has_many :objectives, through: :contributions

  has_many :memberships, as: :memberable, dependent: :destroy
  has_many :members, through: :memberships, source: :contact
  has_many :team_leads, -> { where('memberships.role': 101) },
           through: :memberships, source: :contact
  has_many :sponsors, -> { where('memberships.role': 301) },
           through: :memberships, source: :contact

  enum status: { planning: 0, active: 1, inactive: 2 }

  has_rich_text :context
end
