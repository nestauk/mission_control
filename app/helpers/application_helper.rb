module ApplicationHelper
  def active_nav?(controller: nil, action: nil, classes: 'bg-indigo-800')
    return controller_name.match(controller) && action_name.match(action) ? classes : nil if controller && action
    return controller_name.match(controller) ? classes : nil if controller
    action_name.match(action) ? classes : nil if action
  end

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

  def status_text_color(status)
    case status
    when "scoping"
      "text-purple-700"
    when "committed"
      "text-blue-700"
    when "complete"
      "text-emerald-700"
    when "not_pursued"
      "text-stone-700"
    end
  end

  def status_bg_color(status)
    case status
    when "scoping"
      "bg-purple-700"
    when "committed"
      "bg-blue-700"
    when "complete"
      "bg-emerald-700"
    when "not_pursued"
      "bg-stone-700"
    end
  end

  def with_default(value, text: 'Not provided', check: ommitted = true)
    to_check = ommitted ? value.blank? : check.blank?
    to_check ? tag.span(text, class: 'italic text-gray-600') : value
  end
end
