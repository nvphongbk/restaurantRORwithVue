# frozen_string_literal: true

json.restaurant do
  json.id @restaurant.id
  json.name @restaurant.name
  json.pass_wifi @restaurant.pass_wifi
  json.user_id @restaurant.user_id
  json.address @restaurant.address
  json.categories @categories do |category|
    json.id category.id
    json.name category.name
    json.dishes category.dishes.where(is_active: true) do |dish|
      json.id dish.id
      json.name dish.name
      json.price dish.price
      json.category_ids dish.category_ids
      json.images_attributes dish.images_attributes
      json.image_ids dish.image_ids
      json.position dish.position
      json.is_active dish.is_active
      json.dish_code dish.dish_code
    end
  end
end
