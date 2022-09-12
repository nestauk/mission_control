class Organisation < ApplicationRecord
  scope :ordered, -> { order('LOWER(name)') }

  has_many :contacts
  has_many :memberships, through: :contacts

  validates :name, presence: true
  validates :website, url: { allow_blank: true }

  before_validation { strip_whitespace(%i[name]) }
  before_validation :set_slug

  private

  def set_slug
    return if name.blank?

    self[:slug] = generate_slug(name)
  end
end
