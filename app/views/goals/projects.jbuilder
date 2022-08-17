json.array! @goal.projects do |o|
  json.id o.id
  json.title o.title
  json.content "<span>[#{o.status.humanize}]</span> #{link_to o.title, o}"
  json.start o.start_date
  json.end o.end_date
  json.className o.status
  json.subgroup o.title
end

json.array! @goal.projects.where('planning_start_date IS NOT NULL') do |p|
  json.id "planning_#{p.id}"
  json.title "Planning"
  json.content "Planning"
  json.start p.planning_start_date
  json.end p.start_date
  json.className "planning_phase"
  json.subgroup p.title
end
