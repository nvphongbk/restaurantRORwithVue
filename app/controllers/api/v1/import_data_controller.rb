module Api
  module V1
    class ImportDataController < ApplicationController
      def create
        result = import_data_from(params[:files][0], Dish::IMPORT_COLUMNS)
        if result
          render json: {
            success: true,
            fail: false
          }
        else
          render json: {status: :not_found}
        end
      end
    end
  end
end
