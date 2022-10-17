class Shortcut < ApplicationRecord
  CATEGORIES = %w(Goal Person Project).freeze

  validates :title, :path, presence: true
  validates :category, inclusion: { in: CATEGORIES }
end
