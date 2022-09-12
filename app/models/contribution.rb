class Contribution < ApplicationRecord
  audited associated_with: :project

  belongs_to :goal
  belongs_to :project
end
