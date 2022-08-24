class KeyDate < ApplicationRecord
  belongs_to :project

  validates :date, :title, presence: true
end
