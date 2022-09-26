json.array! @projects do |o|
  json.id o.object_id
  json.title "#{link_to o.title, o} <span>[#{o.status.humanize}]</span>"
  json.content "#{link_to o.title, o} <span>[#{o.status.humanize}]</span>"
  json.start o.start_date
  json.end o.end_date
  json.className o.status
  json.group o.goal_id
  json.subgroup o.title
end

json.array! @projects.where('scoping_start_date IS NOT NULL').select("goals.id AS goal_id", "goals.title AS goal_title", "projects.*") do |p|
  json.id "#{p.goal_id}_scoping_#{p.id}"
  json.title "Scoping"
  json.content "Scoping"
  json.start p.scoping_start_date
  json.end p.start_date
  json.className "scoping_phase"
  json.group p.goal_id
  json.subgroup p.title
end
