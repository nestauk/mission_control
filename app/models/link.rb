class Link < ApplicationRecord
  belongs_to :linkable, polymorphic: true

  validates :url, presence: true, format: {
    with: URI::DEFAULT_PARSER.make_regexp(%w[http https]),
    message: 'enter a valid website address e.g. http://www.example.com'
  }
end
