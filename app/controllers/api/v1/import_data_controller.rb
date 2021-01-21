# frozen_string_literal: true

module Api
  module V1
    class ImportDataController < ApplicationController
      skip_before_action :authenticate_request!
      def create
        restaurant = Restaurant.find(params[:restaurant_id])
        import_data_from(restaurant, params[:files][0], Dish::IMPORT_COLUMNS)
        response json: { status: :success }
      rescue StandardError
        render json: { status: :not_found }
      end
    end
  end
end
