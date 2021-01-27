# frozen_string_literal: true

json.restaurant do
  json.id @restaurant.id
  json.name @restaurant.name
  json.pass_wifi @restaurant.pass_wifi
  json.user_id @restaurant.user_id
  json.address @restaurant.address
  json.phone @restaurant.phone
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
  json.cooking_methods @cooking_methods do |cooking_method|
    json.id cooking_method.id
    json.name cooking_method.name
  end
  json.main_ingredients @main_ingredients do |main_ingredient|
    json.id main_ingredient.id
    json.name main_ingredient.name
  end
end
