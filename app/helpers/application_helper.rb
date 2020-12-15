module ApplicationHelper
  def import_data_from(file, import_columns)
    begin
      datas = RubyXL::Parser.parse(file)
      data = datas[0]
      lines = data.count
      return if lines < 1 || import_columns&.blank?

      header = data[0].cells.map{|i| i.value}
      (1..lines-1).each do |i|
        @images = []
        current_row = Hash.new
        import_columns.keys.each do |key|
          value = data[i][header.find_index(import_columns[key])]&.value
          if key.to_s == 'image'
            image_names = value.split(',')
            return if image_names.blank?

            image_names = image_names.map{|i| i.strip}
            @images = Image.where(image_name: image_names)
          else
            current_row.merge!({ key => value })
          end
        end
        dish = Dish.create!(current_row)
        @images.update_all(dish_id: dish.id)
      end
      true
    rescue
      puts 'error'
    end
  end
end
