json.array! @projects do |o|
  json.id o.object_id
  json.title o.title
  json.content "<span>[#{o.status.humanize}]</span> #{link_to o.title, o}"
  json.start o.start_date
  json.end o.end_date
  json.className o.status
  json.group o.goal_id
end
