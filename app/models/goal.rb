class Goal < ApplicationRecord
  has_one :impact_rating, as: :impactable, dependent: :destroy

  has_many :contributions, dependent: :destroy
  has_many :projects, through: :contributions

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

  enum status: { planning: 0, active: 1, inactive: 2 }

  has_rich_text :context

  validates :title, presence: true
end
