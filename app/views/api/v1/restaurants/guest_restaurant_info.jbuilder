json.restaurant do
  json.id @current_restaurant.id
  json.name @current_restaurant.name
  json.address @current_restaurant.address
  json.user_id @current_restaurant.user_id
  json.pass_wifi @current_restaurant.pass_wifi
  json.phone @current_restaurant.phone
  json.slug @current_restaurant.slug
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
