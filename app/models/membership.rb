class Membership < ApplicationRecord
  belongs_to :contact
  belongs_to :memberable, polymorphic: true

  enum role: {
    team_lead: 101,
    team_member: 102,
    collaborator: 201,
    sponsor: 301,
    coach: 302,
    advisor: 303
  }
  enum role_type: { team: 0, collaborators: 1, supporters: 2 }

  validates :role, presence: true

  before_validation :set_role_type

  private

  def set_role_type
    if role
      return self.role_type = :team if %w[team_lead team_member].include?(role)
      return self.role_type = :collaborators if %w[collaborator].include?(role)
      return self.role_type = :supporters if %w[sponsor coach advisor].include?(role)
    end
  end
end
