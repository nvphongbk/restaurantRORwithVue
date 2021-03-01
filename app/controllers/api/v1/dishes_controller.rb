# frozen_string_literal: true

module Api
  module V1
    class DishesController < ApplicationController
      def index
        @dishes = current_restaurant.dishes.includes(:images, :categories, :main_ingredient, :cooking_method, :menus)
                    .distinct
                    .page(params[:page]).per(params[:per_page])
                    .order(position: :asc, created_at: :desc)
      end

      def show; end

      def create
        dish = Dish.new(dish_params)
        if dish.save
          InitServices::InitDish.new(dish, params[:dish][:images_ids]).perform
          render json: dish, status: 200
        else
          render json: {message: "Can't create dish"}, status: 422
        end
      end

      def update
        dish = Dish.find(params[:id])
        if dish.update(dish_params)
          InitServices::InitDish.new(dish, params[:dish][:images_ids]).perform
          render json: dish, status: 200
        else
          render json: {message: "Can't not update dish"}, status: 422
        end
      end

      def destroy
        @dish = Dish.find(params[:id])
        render json: {status: 'ok deleted'}, status: 200 if @dish.destroy
      end

      def change_active
        @dish = Dish.find(params[:id])
        if @dish.update(is_active: params[:is_active])
          render json: {status: 'ok'}, status: 200
        else
          render json: {message: 'Có lỗi xảy ra'}, status: 422
        end
      end

      def destroy_select
        @dishes = Dish.where(id: params[:id].split(','))
        render json: {status: 'ok deleted'}, status: 200 if @dishes.destroy_all
      end

      private

      def dish_params
        params.require(:dish).permit(:name, :dish_code, :position, :is_active, :restaurant_id,
                                     :main_ingredient_id, :cooking_method_id, category_ids: [],
                                     menu_dishes_attributes: %i[id menu_id dish_id price])
      end
    end
  end
end
