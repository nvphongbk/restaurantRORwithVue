module Api
  module V1
    class ImagesController < ApplicationController
      def create
        @image = Image.new(photo: params[:file])
        if @image.save
          render json: @image, status: 200
        else
          render json: {message: full_error(@image)}, status: 422
        end
      end
    end
  end
end

