module ApplicationHelper
  def last_progress_updates(hash)
    sanitize(hash.map { |k, v|
      "<span class='ml-2 #{k}'>#{v} #{k&.gsub('_', ' ') || 'no updates'}</span>"
    }.join)
  end

  def link_to_add_fields(name, form_builder, association)
    new_object = form_builder.object.send(association).klass.new

    id = new_object.object_id

    fields = form_builder.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + '_fields', f: builder)
    end

    link_to(name, '#', class: 'add_fields link', data: { id: id, fields: fields.gsub("\n", '') })
  end

  def params_active_class(params, param, match_value, classes = 'font-bold no-underline', partial: false)
    param_value = params[:q].try(:fetch, param, nil)
    return classes if partial && param_value == match_value.to_s
    return classes if param_value&.include? match_value.to_s
  end

  def polymorphic_subnav(polymorph)
    "#{to_var(polymorph)}s/subnav"
  end

  def with_default(value, text: 'Not provided', check: ommitted = true)
    to_check = ommitted ? value.blank? : check.blank?
    to_check ? tag.span(text, class: 'italic text-gray-600') : value
  end
end
