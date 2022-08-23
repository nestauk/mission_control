json.array! @goal.projects do |o|
  json.id o.id
  json.title "#{link_to o.title, o} <span>[#{o.status.humanize}]</span>"
  json.content "#{link_to o.title, o} <span>[#{o.status.humanize}]</span>"
  json.start o.start_date
  json.end o.end_date
  json.className o.status
  json.subgroup o.title
end

json.array! @goal.projects.where('scoping_start_date IS NOT NULL') do |p|
  json.id "scoping_#{p.id}"
  json.title "Scoping"
  json.content "Scoping"
  json.start p.scoping_start_date
  json.end p.start_date
  json.className "scoping_phase"
  json.subgroup p.title
end
