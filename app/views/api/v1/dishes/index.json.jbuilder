json.array! @dishes do |dish|
  json.id dish.id
  json.name dish.name
  json.price dish.price
  json.category_ids dish.categories.pluck(:id)

  json.images_attributes dish.images do |image|
    json.id image.id
    json.dish_id image.dish_id
    json.uid image.id
    json.url image.photo&.url
    json.name image.photo.identifier
  end
  json.image_ids dish.images.pluck(:id)
end
