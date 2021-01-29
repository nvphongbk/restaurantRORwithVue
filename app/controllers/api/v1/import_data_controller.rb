# frozen_string_literal: true

module Api
  module V1
    class ImportDataController < ApplicationController
      def create
        import_data_from(current_restaurant, params[:files][0], Dish::IMPORT_COLUMNS)
        response json: { status: :success }
      rescue StandardError
        render json: { status: :not_found }
      end
    end
  end
end
