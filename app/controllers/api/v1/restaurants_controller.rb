# frozen_string_literal: true

module Api
  module V1
    class RestaurantsController < ApplicationController
      skip_before_action :authenticate_request!, only: %w[menus dishes_filter]

      def index
        @restaurants = current_user.restaurants.order(created_at: :desc)
        render json: @restaurants, status: 200
      end

      def show; end

      def create
        @restaurant = Restaurant.new(restaurant_params)
        @restaurant.user_id = current_user.id

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
        render json: {status: 'ok'}, status: 200 if @restaurant.destroy
      end

      def categories
        @restaurant = current_user.restaurants.find(params[:id])
        @categories = @restaurant.categories
        render json: @categories, status: 200
      end

      def main_ingredients
        @main_ingredients = current_restaurant.main_ingredients
        render json: @main_ingredients, status: 200
      end

      def cooking_methods
        @cooking_methods = current_restaurant.cooking_methods
        render json: @cooking_methods, status: 200
      end

      def menus
        @restaurant = Restaurant.friendly.find(params[:id])
        @categories = @restaurant.categories.includes(:dishes).where(is_active: true)
        @cooking_methods = @restaurant.cooking_methods.where(is_active: true)
        @main_ingredients = @restaurant.main_ingredients.where(is_active: true)
      end

      def dishes_filter
        @restaurant = Restaurant.includes(:categories, :dishes).friendly.find(params[:restaurant_id])
        return if @restaurant.blank?

        @dishes = @restaurant.dishes
        @dishes = RestaurantsServices::DishesFilter.new(@restaurant, @dishes, params).perform
      end

      private

      def restaurant_params
        params.require(:restaurant).permit(:name, :address, :pass_wifi, :phone, :user_id)
      end
    end
  end
end
