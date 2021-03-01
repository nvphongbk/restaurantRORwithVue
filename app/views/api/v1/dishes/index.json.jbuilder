# frozen_string_literal: true
json.dishes do
  json.array! @dishes do |dish|
    json.id dish.id
    json.name dish.name
    json.unit dish.unit
    json.is_active dish.is_active
    json.quantity dish.quantity
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

    json.menu_dishes_attributes dish.menu_dishes do |menu_dish|
      json.id menu_dish.id
      json.menu_id menu_dish.menu_id
      json.menu menu_dish.menu, :id, :name
      json.dish_id menu_dish.dish_id
      json.price menu_dish.price
    end
    json.menu_active dish.menus do |menu_active|
      if menu_active.is_active == true
        json.id menu_active.id
        json.name menu_active.name
        json.menu_dishes menu_active.menu_dishes do |menu_dish|
          if dish.id == menu_dish.dish_id
            json.dish_id menu_dish.dish_id
            json.price menu_dish.price
          end
        end
      end
    end

  end
end
json.total @dishes.total_count
