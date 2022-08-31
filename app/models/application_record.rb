class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  private

  def downcase(attrs)
    attrs.each { |attr| self[attr] = self[attr].try(:downcase) }
  end

  def generate_slug(candidate, n: 1)
    slug = candidate.parameterize
    slug += "-#{n}" if n > 1
    return slug unless send(:class).find_by(slug: slug)

    generate_slug(candidate, n: n + 1)
  end

  def strip_whitespace(attrs)
    attrs.each { |attr| self[attr] = self[attr].try(:strip) }
  end
end
