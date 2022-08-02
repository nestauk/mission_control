class Contribution < ApplicationRecord
  belongs_to :goal
  belongs_to :objective
end
