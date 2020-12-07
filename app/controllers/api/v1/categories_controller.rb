module Api
  module V1
    class CategoriesController < ApplicationController

      def index
        @categories = Category.all
      end

      def show;
      end

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
          render json: {message: "Can't create category"}, status: 422
        end
      end

      def update
        @category = Category.find(params[:id])
        if @category.update(category_params)
          render json: @category, status: 200
        else
          render json: {message: "Can't not update category"}, status: 422
        end
      end

      def destroy
        @category = Category.find(params[:id])
        if @category.destroy
          render json: {status: "ok deleted"}, status: 200
        end
      end

      private

      def category_params
          params.require(:category).permit(:name, :restaurant_id)
      end
    end
  end
end
