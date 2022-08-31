class Link < ApplicationRecord
  belongs_to :linkable, polymorphic: true

  validates :name, presence: true
  validates :url, url: { message: 'enter a valid website address e.g. http://www.example.com' }
end
