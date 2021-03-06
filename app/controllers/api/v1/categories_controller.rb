# frozen_string_literal: true

module Api
  module V1
    class CategoriesController < ApplicationController

      def index
        @categories = current_restaurant.categories
      end

      def show;
      end

      def create
        @category = current_restaurant.categories.new(category_params)
        if @category.save
          render json: @category, status: 200
        else
          render json: {message: "Can't create category"}, status: 422
        end
      end

      def update
        @category = current_restaurant.categories.find params[:id]
        if @category.update(category_params)
          render json: {message: "Bạn đã thay đổi thành công"}, status: 200
        else
          render json: {message: "Can't not update category"}, status: 422
        end
      end

      def destroy
        @category = current_restaurant.categories.find(params[:id])
        render json: {status: 'ok deleted'}, status: 200 if @category.destroy
      end

      def dishes
        @category = current_restaurant.categories.find(params[:id])
        @dishes = @category.dishes.includes(:images).page(params[:page]).per(params[:per_page])
        @total = @dishes&.total_count
      end

      def change_active
        @category = current_restaurant.categories.find(params[:id])
        if @category.update(is_active: params[:is_active])
          render json: {status: 'ok'}, status: 200
        else
          render json: {message: 'Có lỗi xảy ra'}, status: 422
        end
      end

      def change_display_home
        @category = current_restaurant.categories.find(params[:id])
        if @category.update(display_home: params[:display_home])
          render json: {status: :ok}, status: 200
        else
          render json: {message: 'Có lỗi xảy ra'}, status: 422
        end
      end

      private

      def category_params
        params.require(:category).permit(:name, :restaurant_id, :position, :is_active)
      end
    end
  end
end
