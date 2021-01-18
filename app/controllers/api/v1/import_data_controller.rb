# frozen_string_literal: true

module Api
  module V1
    class ImportDataController < ApplicationController
      skip_before_action :authenticate_request!
      def create
        result = import_data_from(params[:files][0], Dish::IMPORT_COLUMNS)
        if result
          render json: {
            success: true,
            failure: false
          }
        else
          render json: { status: :not_found }
        end
      end
    end
  end
end
