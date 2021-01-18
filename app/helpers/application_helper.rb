# frozen_string_literal: true

module ApplicationHelper
  def import_data_from(file, import_columns)
    datas = RubyXL::Parser.parse(file)
    data = datas[0]
    lines = data.count
    return if lines < 1 || import_columns&.blank?

    header = data[0].cells.map(&:value)
    (1..lines - 1).each do |i|
      @images = []
      @categories = []
      current_row = {}
      import_columns.each_key do |key|
        value = data[i][header.find_index(import_columns[key])]&.value
        case key.to_s
        when 'image'
          image_names = value.split(',')
          return if image_names.blank?

          image_names = image_names.map(&:strip)
          @images = Image.where(image_name: image_names)
        when 'category'
          category_names = value.split(',')
          return if category_names.blank?

          category_names = category_names.map(&:strip)
          @categories = Category.where(name: category_names)
        else
          current_row.merge!({ key => value })
        end
      end
      dish = Dish.new(current_row)
      dish.categories = @categories if @categories.present?
      dish.save
      @images.update_all(dish_id: dish.id) if @images.present?
    end
    { status: true, message: 'Hoàn thành' }
  rescue => e
    { status: false, message: e.message }
  end
end
