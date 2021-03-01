# frozen_string_literal: true

module InitServices
  class InitDish
    def initialize(dish, images_ids, menu_dishes_attributes)
      @dish = dish
      @images_ids = images_ids
      @menu_dishes_attributes = menu_dishes_attributes
      @menu_ids = [4, 8, 9]
    end

    def perform
      return if @images_ids.blank?

      current_images = @dish.images.pluck(:id)
      Image.where(id: current_images - @images_ids).destroy_all
      images = Image.where(id: @images_ids - current_images)

      return if images.blank?

      images.each do |image|
        image.dish = @dish
        image.save
      end
    end

    def act
      return if @menu_dishes_attributes.blank?

      @dish.menu_dishes.destroy_all
      @menu_dishes_attributes.each do |menu_dishes_attribute|
        menu_dishes = MenuDish.new
        menu_dishes.menu_id = menu_dishes_attribute[:menu_id]
        menu_dishes.price = menu_dishes_attribute[:price]
        menu_dishes.dish_id = @dish.id
        menu_dishes.save
      end
    end
  end
end
