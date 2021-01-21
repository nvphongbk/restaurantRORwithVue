# frozen_string_literal: true

module Api
  module V1
    class CookingMethodsController < ApplicationController
      skip_before_action :authenticate_request!

      def index
        @cooking_methods = CookingMethod.all.includes(:restaurant).order(position: :asc, name: :asc)
      end

      def show; end

      def new
        @cooking_method = CookingMethod.new
      end

      def edit
        @cooking_method = CookingMethod.find(params[:id])
      end

      def create
        @cooking_method = CookingMethod.new(cooking_method_params)

        if @cooking_method.save
          render json: @cooking_method, status: 200
        else
          render json: { message: "Can't create cooking_method" }, status: 422
        end
      end

      def update
        @cooking_method = CookingMethod.find(params[:id])
        if @cooking_method.update(cooking_method_params)
          render json: @cooking_method, status: 200
        else
          render json: { message: "Can't not update cooking_method" }, status: 422
        end
      end

      def destroy
        @cooking_method = CookingMethod.find(params[:id])
        render json: { status: 'ok' }, status: 200 if @cooking_method.destroy
      end

      def change_active
        cooking_method = CookingMethod.find(params[:id])
        if cooking_method.update(is_active: params[:is_active])
          render json: { status: 'ok' }, status: 200
        else
          render json: { message: 'Có lỗi xảy ra' }, status: 422
        end
      end

      private

      def cooking_method_params
        params.require(:cooking_method).permit(:name, :position, :is_active, :restaurant_id)
      end
    end
  end
end
