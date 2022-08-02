class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  private

  def strip_whitespace(attrs)
    attrs.each { |attr| self[attr] = self[attr].try(:strip) }
  end
end
