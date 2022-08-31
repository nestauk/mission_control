class Tag < ApplicationRecord
  has_many :taggings

  validates :title, presence: true
end
