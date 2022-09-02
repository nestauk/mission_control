class ImpactType < ApplicationRecord
  has_many :indicators
  has_many :impact_rigours

  enum category: { direct: 0, indirect: 1 }
end
