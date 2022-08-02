module ApplicationHelper
  def with_default(value, text: 'Not provided', check: ommitted = true)
    to_check = ommitted ? value.blank? : check.blank?
    to_check ? tag.span(text, class: 'italic text-gray-600') : value
  end
end
