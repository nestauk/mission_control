class Contact < ApplicationRecord
  belongs_to :person
  belongs_to :organisation, optional: true

  has_one :user

  # has_many :authorships
  # has_many :progress_updates, through: :authorships, source: :authorable, source_type: 'ProgressUpdate'

  has_many :memberships, dependent: :destroy
  has_many :goals, through: :memberships, source: :memberable, source_type: 'Goal'
  has_many :projects, through: :memberships, source: :memberable, source_type: 'Project'

  validates :first_name, :last_name, :email, :status, presence: true
  validates_uniqueness_of :email
  validates_format_of :email, with: Devise.email_regexp

  before_validation :sync_name
  before_validation { downcase(%i[email]) }

  enum status: %i[current past]

  def name
    "#{first_name} #{last_name}"
  end

  private

  def sync_name
    return unless person

    self[:first_name] = person.first_name
    self[:last_name] = person.last_name
  end
end
