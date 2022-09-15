class Person < ApplicationRecord
  audited
  has_associated_audits

  has_many :contacts, dependent: :destroy
  has_many :users, through: :contacts
  has_many :organisations, through: :contacts

  has_many :memberships, through: :contacts
  has_many :goals, through: :memberships, source: :memberable, source_type: 'Goal'
  has_many :projects, through: :memberships, source: :memberable, source_type: 'Project'

  accepts_nested_attributes_for :contacts, allow_destroy: true

  validates :first_name, :last_name, presence: true

  before_validation { strip_whitespace(%i[first_name last_name]) }
  before_validation :set_slug

  ransacker :name do
    Arel.sql("CONCAT_WS(' ', people.first_name, people.last_name)")
  end

  def to_param
    slug
  end

  def name
    "#{first_name} #{last_name}"
  end

  private

  def set_slug
    return if name.blank?

    self[:slug] = generate_slug(name)
  end
end
