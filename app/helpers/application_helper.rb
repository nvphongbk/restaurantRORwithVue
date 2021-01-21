# frozen_string_literal: true

module ApplicationHelper
  def import_data_from(restaurant, file, import_columns)
    datas = RubyXL::Parser.parse(file)
    data = datas[0]
    lines = data.count
    return if lines < 1 || import_columns&.blank?

    list_categories_name = restaurant.categories.present? ? restaurant.categories.pluck(:name) : []
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
        else
          current_row.merge!({ key => value }) if value.present?
        end
      end
      dish = Dish.new(current_row)
      dish.categories = @categories if @categories.present?
      dish.main_ingredient_id = @main_ingredient.id
      dish.cooking_method_id = @cooking_method.id
      dish.save
      @images.update_all(dish_id: dish.id) if @images.present?
    end
    { status: true, message: 'Hoàn thành' }
  rescue StandardError => e
    { status: false, message: e.message }
  end
end
