json.array! @categories do |category|
  json.restaurant_id category.restaurant_id
  json.name category.name
  json.id category.id
end
