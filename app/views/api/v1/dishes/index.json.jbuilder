# frozen_string_literal: true
json.dishes do
  json.array! @dishes do |dish|
    json.id dish.id
    json.name dish.name
    json.unit dish.unit
    json.is_active dish.is_active
    json.quantity dish.quantity
    json.price dish.price
    json.main_ingredient_id dish.main_ingredient&.id
    json.cooking_method_id dish.cooking_method&.id
    json.main_ingredient do
      json.id dish.main_ingredient&.id
      json.name dish.main_ingredient&.name
    end
    json.cooking_method do
      json.id dish.cooking_method&.id
      json.name dish.cooking_method&.name
    end
    json.price dish.price
    json.category_ids dish.categories.pluck(:id)
    json.categories dish.categories do |category|
      json.id category&.id
      json.name category&.name
    end

    json.images_attributes dish.images do |image|
      json.id image&.id
      json.dish_id image&.dish_id
      json.uid image&.id
      json.url image&.photo&.url
      json.name image&.photo&.identifier
    end
    json.image_ids dish.images&.pluck(:id)
  end
end
json.total @dishes.total_count
