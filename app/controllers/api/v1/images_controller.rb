# frozen_string_literal: true

module Api
  module V1
    class ImagesController < ApplicationController
      skip_before_action :authenticate_request!
      def index
        @images = Image.all
      end

      def create
        @image = Image.new(photo: params[:file])
        if @image.save
          render json: @image, status: 200
        else
          render json: { message: "Can't not create image" }, status: 422
        end
      end

      def destroy
        @image = Image.find(params[:id])
        render json: {message: 'Xoá thành công'}, status: 200 if @image.destroy
      end
    end
  end
end
