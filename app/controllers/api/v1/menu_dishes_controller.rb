module Api
  module V1
    class MenuDishesController < ApplicationController
      def destroy
        @menu_dish = MenuDish.find(params[:id])
        render json: {status: 'ok deleted'}, status: 200 if @menu_dish.destroy
      end
    end
  end
end
