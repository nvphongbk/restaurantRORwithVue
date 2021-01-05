module Api
  module V1
    class CategoryDishesController < ApplicationController
      def create
        @category_dishes = CategoryDish.new(category_dish_params)

        if @category_dishes.save
          render json: @category_dishes, status: 200
        else
          render json: {message: "Can't create category dish"}, status: 422
        end
      end

      private

      def category_dish_params
        params.require(:category_dish).permit(:category_id, :dish_id)
      end
    end
  end
end
