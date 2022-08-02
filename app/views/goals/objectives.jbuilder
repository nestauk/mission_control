json.array! @goal.objectives do |o|
  json.id o.id
  json.content o.title
  json.start o.start_date
  json.end o.end_date
end
