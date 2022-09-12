class Tagging < ApplicationRecord
  audited associated_with: :taggable

  belongs_to :taggable, polymorphic: true
  belongs_to :tag
end
