# frozen_string_literal: true

json.array! @main_ingredients do |ingredient|
  json.id ingredient.id
  json.name ingredient.name
  json.position ingredient.position
  json.is_active ingredient.is_active
  json.restaurant_id ingredient.restaurant.id
end
