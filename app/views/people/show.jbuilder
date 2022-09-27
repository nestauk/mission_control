json.array! @projects do |o|
  json.id o.object_id
  json.title o.title
  json.content "#{link_to o.title, o} <span>[#{o.status.humanize}]</span>"
  json.start o.start_date
  json.end o.end_date
  json.className o.status
  json.group o.membership_role
  json.subgroup o.title
end

json.array! @projects.where('scoping_start_date IS NOT NULL') do |p|
  json.id "#{p.membership_role}_scoping_#{p.id}"
  json.title "Scoping"
  json.content "Scoping"
  json.start p.scoping_start_date
  json.end p.start_date
  json.className "scoping_phase"
  json.group p.membership_role
  json.subgroup p.title
end
