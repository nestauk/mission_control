class Objective < ApplicationRecord
  has_one :impact_rating, as: :impactable, dependent: :destroy

  has_many :contributions, dependent: :destroy
  has_many :goals, through: :contributions

  has_many :taggings, as: :taggable, dependent: :destroy
  has_many :tags, through: :taggings

  has_many :indicators, as: :targetable, dependent: :destroy
  has_many :links, as: :linkable, dependent: :destroy

  has_many :memberships, as: :memberable, dependent: :destroy
  has_many :members, through: :memberships, source: :contact
  has_many :team_leads, -> { where('memberships.role': Membership.roles[:team_lead]) },
           through: :memberships, source: :contact
  has_many :team, -> { where('memberships.role': [Membership.roles[:team_lead], Membership.roles[:team_member]]) },
           through: :memberships, source: :contact
  has_many :sponsors, -> { where('memberships.role': Membership.roles[:sponsor]) },
           through: :memberships, source: :contact

  enum status: { planning: 0, committed: 1, complete: 2, not_pursued: 3 }, _prefix: :status

  has_rich_text :context
  has_rich_text :expectations

  validates :title, :objective, presence: true
end
