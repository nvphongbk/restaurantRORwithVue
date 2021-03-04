module Api
  module V1
    class BackgroundsController < ApplicationController

      def index
        @background = current_restaurant.background
        render json: @background, status: 200
      end

      def create
          @background = Background.new(photo: params[:file])
        if @background.save
          render json: @background, status: 200
        else
          render json: {message: @background.errors}, status: 422
        end
      end

      def update
        @background = Background.find(params[:id])
        Background.where(restaurant_id: params[:background][:restaurant_id]).delete_all
        if @background.update(background_params)
          render json: @background, status: 200
        else
          render json: {message: @background.errors}, status: 422
        end
      end

      def background_params
        params.require(:background).permit(:restaurant_id)
      end
    end
  end
end
