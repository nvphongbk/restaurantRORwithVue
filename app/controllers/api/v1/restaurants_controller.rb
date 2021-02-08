# frozen_string_literal: true

module Api
  module V1
    class RestaurantsController < ApplicationController
      skip_before_action :authenticate_request!, only: %w[guest_index menus guest_dishes guest_restaurant_info]

      def index
        @restaurants = current_user.restaurants.order(created_at: :desc)
      end

      def guest_index
        @restaurants = Restaurant.order(created_at: :desc)
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
        render json: {status: 'ok'} if @restaurant.destroy
      end

      def categories
        @categories = current_restaurant.categories
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

      def guest_restaurant_info
        @restaurant = Restaurant.friendly.find(params[:id])
        @categories = @restaurant.categories.includes(:dishes).where(is_active: true)
        @display_categories = @restaurant.categories.includes(:dishes).where(is_active: true, display_home: true)
        @cooking_methods = @restaurant.cooking_methods.where(is_active: true)
        @main_ingredients = @restaurant.main_ingredients.where(is_active: true)
      end

      def guest_dishes
        @restaurant = Restaurant.friendly.find(params[:id])
        return if @restaurant.blank?
        @dishes = if params[:category_id].present?
                    @restaurant.dishes.includes(:images, :categories, :main_ingredient, :cooking_method)
                      .where(categories: {id: params[:category_id]})
                      .page(params[:page]).per(params[:per_page])
                  else
                    @restaurant.dishes.includes(:images, :categories, :main_ingredient, :cooking_method)
                      .page(params[:page]).per(params[:per_page])
                  end

        @total = @dishes&.total_count
      end

      private

      def restaurant_params
        params.require(:restaurant).permit(:name, :address, :pass_wifi, :phone, :user_id)
      end

      def filtering_params
        filter_search(params).slice(:main_ingredient_id, :cooking_method_id, :categories)
      end
    end
  end
end
