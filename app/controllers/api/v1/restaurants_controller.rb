module Api
  module V1
    class RestaurantsController < ApplicationController
      def index
        @restaurants = Restaurant.all
        render json: @restaurants, status: 200
      end

      def show; end

      def new
        @restaurant = Restaurant.new
      end

      def edit
        @restaurant = Restaurant.find(params[:id])
      end

      def create
        @restaurant = Restaurant.new(restaurant_params)

        if @restaurant.save
          render json: @restaurant, status: 200
        else
          render json: {message: "Can't create restaurant"}, status: 422
        end
      end
      def update
        @restaurant = Restaurant.find(params[:id])
        if @restaurant.update(restaurant_params)
          render json: @restaurant, status: 200
        else
          render json: {message: "Can't not update restaurant"}, status: 422
        end
      end

      def destroy
        @restaurant = Restaurant.find(params[:id])
        if @restaurant.destroy
          render json: {status: "ok"}, status: 200
        end
      end

      private

      def restaurant_params
        params.require(:restaurant).permit(:name, :address, :user_id)
      end
    end
  end
end
