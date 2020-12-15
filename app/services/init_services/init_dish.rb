module InitServices
  class InitDish
    def initialize(dish, images_ids)
      @dish = dish
      @images_ids = images_ids
    end

    def perform
      binding.pry
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
  end
end
