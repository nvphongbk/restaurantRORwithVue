json.restaurant do
  json.id @restaurant.id
  json.name @restaurant.name
  json.address @restaurant.address
  json.user_id @restaurant.user_id
  json.pass_wifi @restaurant.pass_wifi
  json.phone @restaurant.phone
  json.slug @restaurant.slug
end
json.cooking_methods do
  json.array! @cooking_methods do |cooking_method|
    json.id cooking_method.id
    json.name cooking_method.name
    json.is_active cooking_method.is_active
  end
end
json.main_ingredients do
  json.array! @main_ingredients do |item|
    json.id item.id
    json.name item.name
    json.is_active item.is_active
  end
end
json.categories do
  json.array! @categories do |item|
    json.id item.id
    json.name item.name
    json.is_active item.is_active
  end
end