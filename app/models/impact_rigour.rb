class ImpactRigour < ApplicationRecord
  belongs_to :impact_type
  has_many :impact_levels
end
