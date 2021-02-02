# frozen_string_literal: true

json.dishes do
  json.array! @dishes do |dish|
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
json.total @total
