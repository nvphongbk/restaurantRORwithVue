# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      def index
        @users = current_user
        render json: @users
      end

      def new
        @user = User.new
        render json: @user, status: 200
      end

      def show
        @user = User.find(params[:id])
        render_jsonapi_response(@user)
      end

      def create
        @user = User.new(user_params)
        if @user.save
          render json: @user, status: 200
        else
          render json: { message: 'not create user' }, status: 422
        end
      end

      def edit
        @user = User.find(params[:id])
      end

      def update
        @user = User.find(params[:id])
        if @user.update_attributes(user_params)
          render json: @user, status: 200
        else
          render json: { message: @user.errors }, status: 422
        end
      end

      def get_info
        @restaurants = current_user.restaurants
        @categories = current_restaurant.categories.where(is_active: true)
      end

      def change_restaurant_default
        restaurant = current_user.restaurants.find(params[:id])
        if restaurant
          current_user.update(default_restaurant_id: restaurant.id)
          render json: { message: 'Bạn đổi cửa hàng thành công' }, status: 200
        else
          render json: { message: 'Bạn chỉnh sửa không đúng thôi tin' }, status: 422
        end
      end

      private

      def user_params
        params.require(:user).permit(:email, :password_digest)
      end
    end
  end
end
