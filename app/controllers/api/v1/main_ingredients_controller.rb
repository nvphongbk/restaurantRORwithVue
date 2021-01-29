# frozen_string_literal: true

module Api
  module V1
    class MainIngredientsController < ApplicationController

      def index
        @restaurant_ids = current_user.restaurants&.pluck(:id)
        @main_ingredients = MainIngredient.all.where(restaurant_id: @restaurant_ids).order(position: :asc, name: :asc)
      end

      def show; end

      def new
        @main_ingredient = MainIngredient.new
      end

      def edit
        @main_ingredient = MainIngredient.find(params[:id])
      end

      def create
        @main_ingredient = MainIngredient.new(main_ingredient_params)

        if @main_ingredient.save
          render json: @main_ingredient, status: 200
        else
          render json: { message: "Can't create main_ingredient" }, status: 422
        end
      end

      def update
        @main_ingredient = MainIngredient.find(params[:id])
        if @main_ingredient.update(main_ingredient_params)
          render json: @main_ingredient, status: 200
        else
          render json: { message: "Can't not update main_ingredient" }, status: 422
        end
      end

      def destroy
        @main_ingredient = MainIngredient.find(params[:id])
        render json: { status: 'ok' }, status: 200 if @main_ingredient.destroy
      end

      def change_active
        main_ingredient = MainIngredient.find(params[:id])
        if main_ingredient.update(is_active: params[:is_active])
          render json: { status: 'ok' }, status: 200
        else
          render json: { message: 'Có lỗi xảy ra' }, status: 422
        end
      end

      def dishes
        @main_ingredient = MainIngredient.find(params[:id])
        @dishes = @main_ingredient.dishes.includes(:images)
        render json: @dishes
      end

      private

      def main_ingredient_params
        params.require(:main_ingredient).permit(:name, :position, :is_active, :restaurant_id)
      end
    end
  end
end
