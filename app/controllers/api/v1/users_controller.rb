# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      before_action :find_user, only: %w[show]
      def index
        @users = current_user
        render json: @users
      end

      def new
        @user = User.new
        render json: @user, status: 200
      end

      def show
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
          render json: { message: 'not create user' }, status: 422
        end
      end

      def find_user
        @user = User.find(params[:id])
      end

      private

      def user_params
        params.require(:user).permit(:email, :password_digest)
      end
    end
  end
end
