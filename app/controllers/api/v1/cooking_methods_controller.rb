# frozen_string_literal: true

module Api
  module V1
    class CookingMethodsController < ApplicationController

      def index
        @restaurant_ids = current_user.restaurants&.pluck(:id)
        @cooking_methods = current_restaurant.cooking_methods.order(position: :asc, name: :asc)
      end

      def show
        @cooking_method = current_restaurant.cooking_methods.find(params[:id])
      end

      def create
        @cooking_method = current_restaurant.cooking_methods.new(cooking_method_params)

        if @cooking_method.save
          render json: @cooking_method, status: 200
        else
          render json: { message: "Can't create cooking_method" }, status: 422
        end
      end

      def update
        @cooking_method = current_restaurant.cooking_methods.find(params[:id])
        if @cooking_method.update(cooking_method_params)
          render json: @cooking_method, status: 200
        else
          render json: { message: "Can't not update cooking_method" }, status: 422
        end
      end

      def destroy
        @cooking_method = current_restaurant.cooking_methods.find(params[:id])
        render json: { status: 'ok' }, status: 200 if @cooking_method.destroy
      end

      def change_active
        cooking_method = current_restaurant.cooking_methods.find(params[:id])
        if cooking_method.update(is_active: params[:is_active])
          render json: { status: 'ok' }, status: 200
        else
          render json: { message: 'Có lỗi xảy ra' }, status: 422
        end
      end

      def dishes
        @cooking_method = current_restaurant.cooking_methods.find(params[:id])
        @dishes = @cooking_method.dishes.includes(:images)
        render json: @dishes
      end

      private

      def cooking_method_params
        params.require(:cooking_method).permit(:name, :position, :is_active, :restaurant_id)
      end
    end
  end
end
