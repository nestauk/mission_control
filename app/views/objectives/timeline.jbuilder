json.array! @objectives do |o|
  json.id o.object_id
  json.content o.title
  json.start o.start_date
  json.end o.end_date
  json.group o.goal_title
  json.className o.status
end
