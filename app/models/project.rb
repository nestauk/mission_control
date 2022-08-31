class Project < ApplicationRecord
  has_one :impact_rating, as: :impactable, dependent: :destroy

  has_many :key_dates, dependent: :destroy

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

  enum ambition: { improving: 0, constraint_breaking: 1, visionary: 2 }
  enum impact_type: { direct: 0, indirect: 1 }
  enum geography: { uk: 0, england: 1, wales: 2, scotland: 3, northern_ireland: 4 }
  enum phase: { validate_an_opportunity: 1, develop_a_valid_concept: 2, establish_a_proven_solution: 3, deepen_impact: 4 }
  enum status: { scoping: 0, committed: 1, complete: 2, not_pursued: 3 }, _prefix: :status

  has_rich_text :context
  has_rich_text :expectations

  validates :title, :objective, :status, :start_date, presence: true

  before_validation { strip_whitespace(%i[title]) }
end
