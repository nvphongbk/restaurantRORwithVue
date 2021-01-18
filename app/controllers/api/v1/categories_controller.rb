# frozen_string_literal: true

module Api
  module V1
    class CategoriesController < ApplicationController
      def index
        @categories = Category.all.order(position: :asc, created_at: :desc)
      end

      def show; end

      def new
        @category = Category.new
      end

      def edit
        @category = Category.find(params[:id])
      end

      def create
        @category = Category.new(category_params)
        if @category.save
          render json: @category, status: 200
        else
          render json: { message: "Can't create category" }, status: 422
        end
      end

      def update
        @category = Category.find(params[:id])
        if @category.update(category_params)
          render json: @category, status: 200
        else
          render json: { message: "Can't not update category" }, status: 422
        end
      end

      def destroy
        @category = Category.find(params[:id])
        render json: { status: 'ok deleted' }, status: 200 if @category.destroy
      end

      def dishes
        @category = Category.find(params[:id])
        @dishes = @category.dishes
        render json: @dishes, status: 200
      end

      def change_active
        @category = Category.find(params[:id])
        if @category.update(is_active: params[:is_active])
          render json: { status: 'ok' }, status: 200
        else
          render json: { message: 'Có lỗi xảy ra' }, status: 422
        end
      end

      private

      def category_params
        params.require(:category).permit(:name, :restaurant_id, :position, :is_active)
      end
    end
  end
end
