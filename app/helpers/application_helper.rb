# frozen_string_literal: true

module ApplicationHelper
  def filter_search(params)
    params.select { |k, value| value.present? }
  end

  def format_character(char)
    char&.strip&.downcase
  end

  def import_data_from(restaurant, file, import_columns)
    datas = RubyXL::Parser.parse(file)
    data = datas[0]
    lines = data.count
    return if lines < 1 || import_columns&.blank?

    list_categories_name = restaurant.categories.present? ? restaurant.categories.pluck(:name) : []
    list_menu_name = restaurant.menus.present? ? restaurant.menus.pluck(:name) : []
    current_menu_name = []
    list_price = []
    header = data[0].cells.map(&:value)
    (1..lines - 1).each do |i|
      @images = []
      @categories = []
      current_row = {}
      import_columns.each_key do |key|
        index = header.find_index(import_columns[key])
        puts key
        # next if index.blank?
        value = data[i][index]&.value
        case key.to_s
        when 'image'
          if value.present?
            image_names = value.split(',')
            image_names = image_names.map(&:strip)
            @images = Image.where(image_name: image_names)
          end
        when 'category'
          category_names = if value.blank?
                             ['Khác']
                           else
                             value.split(',')
                           end
          category_names = category_names.map(&:strip)
          new_categories = category_names - list_categories_name
          if new_categories.present?
            new_categories.each do |category|
              restaurant.categories.create(name: category)
              list_categories_name.push(category)
            end
          end
          @categories = restaurant.categories.where(name: category_names)
        when 'cooking_method'
          cooking_method_name = value || 'Khác'
          @cooking_method = restaurant.cooking_methods.find_or_create_by(name: cooking_method_name)
        when 'main_ingredient'
          main_ingredient_name = value || 'Khác'
          @main_ingredient = restaurant.main_ingredients.find_or_create_by(name: main_ingredient_name)
        when 'price'
          price = value.to_s.split(',')
          price = price.map(&:strip)
          list_price = price
        when 'menu'
          menu_name = if value.blank?
                        ['Khác']
                      else
                        value.split(',')
                      end
          menu_name = menu_name.map(&:strip)
          current_menu_name = menu_name
          new_menu_name = menu_name - list_menu_name

          if new_menu_name.present?

            new_menu_name.each do |menu|
              restaurant.menus.create(name: menu)
              @menu = restaurant.menus.where(name: menu_name)
              list_menu_name.push(menu)
            end
          else
            @menu = restaurant.menus.where(name: menu_name)
          end
        else
          current_row.merge!({key => value}) if value.present?
        end
      end
      name = format_character(current_row[:name])
      dish = if restaurant.dishes.present? && name.present?
               restaurant.dishes.where(name: name)&.first
             else
               false
             end
      if dish.present?
        if @menu.present?
          update_menu = @menu - dish.menus
          if update_menu.present?
            dish.menus.push(update_menu)
            update_menu = dish.menus - @menu
            dish.menus.delete(update_menu)
          else
            update_menu = dish.menus - @menu
            dish.menus.delete(update_menu)
          end
          dish.save
        else
          dish.menus.destroy_all
        end
        if list_price.present?
          $i = 0
          $num = dish.menu_dishes.length - 1
          begin
            @menu_dishes = dish.menu_dishes.where(menu_id: dish.menus.where(name: current_menu_name[$i]).first.id).update(price: list_price[$i])
            $i += 1;
          end until $i > $num
        end
      else
        current_row[:name] = format_character(current_row[:name])
        dish = Dish.new(current_row)
        dish.menus = @menu if @menu.present?
        dish.categories = @categories if @categories.present?
        dish.main_ingredient_id = @main_ingredient.id
        dish.cooking_method_id = @cooking_method.id
        dish.save
        @images.update_all(dish_id: dish.id) if @images.present?
        $i = 0
        $num = dish.menu_dishes.length - 1
        begin
          @menu_dishes = dish.menu_dishes.where(menu_id: dish.menus.where(name: current_menu_name[$i]).first.id).update(price: list_price[$i])
          $i += 1;
        end until $i > $num
      end
    end
    {status: true, message: 'Hoàn thành'}
  rescue StandardError => e
    {status: false, message: e.message}
  end
end
