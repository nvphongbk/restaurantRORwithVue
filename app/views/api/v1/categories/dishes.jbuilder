json.array! @dishes do |dish|
  json.id dish.id
  json.name dish.name
  json.price dish.price
  json.category_ids dish.category_ids
  json.images_attributes dish.images
  json.image_ids dish.image_ids
  json.position dish.position
  json.is_active dish.is_active
  json.dish_code dish.dish_code
end
