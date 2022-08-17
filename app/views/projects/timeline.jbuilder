json.array! @projects do |o|
  json.id o.object_id
  json.title o.title
  json.content "<span>[#{o.status.humanize}]</span> #{link_to o.title, o}"
  json.start o.start_date
  json.end o.end_date
  json.className o.status
  json.group o.goal_id
  json.subgroup o.title
end

json.array! @projects.where('planning_start_date IS NOT NULL').select("goals.id AS goal_id", "goals.title AS goal_title", "projects.*") do |p|
  json.id "planning_#{p.id}"
  json.title "Planning"
  json.content "Planning"
  json.start p.planning_start_date
  json.end p.start_date
  json.className "planning_phase"
  json.group p.goal_id
  json.subgroup p.title
end
