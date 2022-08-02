class Organisation < ApplicationRecord
  scope :ordered, -> { order('LOWER(name)') }

  has_many :contacts
  has_many :memberships, through: :contacts

  validates :name, presence: true
  # validates :website, url: { allow_blank: true }

  after_save :set_slug

  private

  def set_slug
    return unless slug.nil? || name_changed? || public_uid_changed?

    update(slug: generate_slug("#{public_uid}-#{name}"))
  end
end
