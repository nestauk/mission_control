class Goal < ApplicationRecord
  audited
  has_associated_audits

  generate_public_uid generator: PublicUid::Generators::NumberRandom.new(100_000..999_999)

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

  enum status: { scoping: 0, active: 1, inactive: 2 }, _prefix: :status

  has_rich_text :context

  validates :title, presence: true

  before_validation { strip_whitespace(%i[title]) }

  def self.find_puid(param)
    find_by(public_uid: param&.split('-')&.last)
  end

  def to_param
    "goal-#{public_uid}"
  end
end
