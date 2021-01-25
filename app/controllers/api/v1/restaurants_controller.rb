# frozen_string_literal: true

module Api
  module V1
    class RestaurantsController < ApplicationController
      skip_before_action :authenticate_request!, only: %w[index menus]
      def index
        @restaurants = Restaurant.all.order(created_at: :desc)
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
        @restaurant.user_id = current_user.id

        if @restaurant.save
          render json: @restaurant, status: 200
        else
          render json: { message: "Can't create restaurant" }, status: 422
        end
      end

      def update
        @restaurant = Restaurant.find(params[:id])
        if @restaurant.update(restaurant_params)
          render json: @restaurant, status: 200
        else
          render json: { message: "Can't not update restaurant" }, status: 422
        end
      end

      def destroy
        @restaurant = Restaurant.find(params[:id])
        render json: { status: 'ok' }, status: 200 if @restaurant.destroy
      end

      def categories
        @restaurant = Restaurant.find(params[:id])
        @categories = @restaurant.categories
        render json: @categories
      end

      def menus
        @restaurant = Restaurant.friendly.find(params[:id])
        @categories = @restaurant.categories.includes(:dishes).where(is_active: true)
        @cooking_methods = @restaurant.cooking_methods.where(is_active: true)
        @main_ingredients = @restaurant.main_ingredients.where(is_active: true)
      end

      def dishes_filter
        @restaurant = Restaurant.includes(:categories, :dishes).find(params[:restaurant_id])
        return if @restaurant.blank?

        @dishes = @restaurant.dishes
        @dishes = RestaurantsServices::DishesFilter.new(@restaurant, @dishes, params).perform
      end

      private

      def restaurant_params
        params.require(:restaurant).permit(:name, :address, :pass_wifi, :user_id)
      end
    end
  end
end
