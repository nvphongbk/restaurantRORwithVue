module Api
  module V1
    class UsersController < ApplicationController
      def index; end

      def new
        @user = User.new
        render json: @user, status: 200
      end

      def show; end

      def create
        @user = User.new(user_params)
        if @user.save
          render json: @user, status: 200
        else
          render json: {message: "not create user"}, status: 422
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
            render json: { message: "not create user" }, status: 422
          end
      end

      private

      def user_params
        params.require(:user).permit(:email, :password_digest)
      end
    end
  end
end
