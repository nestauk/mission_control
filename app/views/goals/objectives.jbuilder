json.array! @goal.objectives do |o|
  json.id o.id
  json.title o.title
  json.content "<span>[#{o.status.humanize}]</span> #{link_to o.title, o}"
  json.start o.start_date
  json.end o.end_date
  json.className o.status
end
