# frozen_string_literal: true

json.dishes do
  json.array! @dishes do |dish|
    json.id dish.id
    json.name dish.name
    json.category_ids dish.category_ids
    json.images_attributes dish.images_attributes
    json.image_ids dish.image_ids
    json.position dish.position
    json.is_active dish.is_active
    json.dish_code dish.dish_code

    json.menus dish.menus do |menu|
      if menu.is_active == true
        json.id menu.id
        json.name menu.name
        json.menu_dishes menu.menu_dishes do |menu_dish|
          if dish.id == menu_dish.dish_id
            json.price menu_dish.price
          end
        end
      end
    end
  end
end
json.total @total
