module Api
  module V1
    class DishesController < ApplicationController

      def index
        @dishes = Dish.all
        render json: @dishes, status: 200
      end

      def show;
      end

      def new
        @dish = Dish.new
      end

      def edit
        @dish = Dish.find(params[:id])
      end

      def create
        @dish = Dish.new(dish_params)

        if @dish.save
          render json: @dish, status: 200
        else
          render json: {message: "Can't create dish"}, status: 422
        end
      end

      def update
        @dish = Dish.find(params[:id])
        if @dish.update(dish_params)
          render json: @dish, status: 200
        else
          render json: {message: "Can't not update dish"}, status: 422
        end
      end

      def destroy
        @dish = Dish.find(params[:id])
        if @dish.destroy
          render json: {status: "ok deleted"}, status: 200
        end
      end

      private

      def dish_params
        params.require(:dish).permit(:name, :price, :image)
      end
    end
  end
end
