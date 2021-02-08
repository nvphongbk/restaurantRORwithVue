module RestaurantsServices
  class DishesFilter
    def initialize(restaurant, dishes, params)
      @restaurant = restaurant
      @dishes = dishes
      @params = params
    end

    def perform
      filter_by_category if @params[:category_ids].present?
      filter_by_main_ingredient if @params[:main_ingredient_ids].present?
      filter_by_cooking_method  if @params[:cooking_method_ids].present?
      @dishes
    end

    private

    def filter_by_category
      @dishes = @dishes.where(categories: { id: @params[:category_ids] }).distinct
    end

    def filter_by_main_ingredient
      @dishes = @dishes.where(main_ingredient_id: @params[:main_ingredient_ids])
    end

    def filter_by_cooking_method
      @dishes = @dishes.where(cooking_method_id: @params[:cooking_method_ids])
    end
  end
end
