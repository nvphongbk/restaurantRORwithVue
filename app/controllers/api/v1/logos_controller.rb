module Api
  module V1
    class LogosController < ApplicationController

      def index
        @logos = current_restaurant.logo
        render json: @logos, status: 200
      end

      def create
        @logo = Logo.new(photo: params[:file])
        if @logo.save
          render json: @logo, status: 200
        else
          render json: {message: 'Không thể upload logo'}, status: 422
        end
      end

      def update
        @logo = Logo.find(params[:id])
        Logo.where(restaurant_id: params[:logo][:restaurant_id]).delete_all
        if @logo.update_attributes(logo_params)
          render json: @logo, status: 200
        else
          render json: {message: @logo.error}, status: 422
        end
      end

      def logo_params
        params.require(:logo).permit(:restaurant_id)
      end
    end
  end
end
