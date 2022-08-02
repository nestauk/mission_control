class Person < ApplicationRecord
  has_many :contacts, dependent: :destroy
  has_many :users, through: :contacts
  has_many :organisations, through: :contacts

  has_many :memberships, through: :contacts
  has_many :goals, through: :memberships, source: :memberable, source_type: 'Goal'
  has_many :objectives, through: :memberships, source: :memberable, source_type: 'Objective'

  accepts_nested_attributes_for :contacts, allow_destroy: true

  validates :first_name, :last_name, presence: true

  after_save :set_slug

  def name
    "#{first_name} #{last_name}"
  end

  def primary_contact
    contacts.min_by{ |c| c.status }
  end

  private

  def set_slug
    return unless slug.nil? || first_name_changed? || last_name_changed?

    update(slug: generate_slug(name))
  end

  ransacker :name do
    Arel.sql("CONCAT_WS(' ', people.first_name, people.last_name)")
  end
end
