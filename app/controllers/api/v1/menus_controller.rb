module Api
  module V1
    class MenusController < ApplicationController

      def index
        @menus = current_restaurant.menus
        render json: @menus
      end

      def create
        @menu = current_restaurant.menus.new(menu_params)
        if @menu.is_active == true
          current_restaurant.menus.update_all(is_active: false)
          if @menu.save
            render json: @menu, status: 200
          else
            render json: @menu.errors, status: 422
          end
        else
          if @menu.save
            render json: @menu, status: 200
          else
            render json: @menu.errors, status: 422
          end
        end
      end

      def update
        @menu = current_restaurant.menus.find(params[:id])
        if @menu
          current_restaurant.menus.update_all(is_active: false)
          @menu.update(is_active: true)
          render json: @menu, status: 200
        else
          render json: @menu.errors, status: 422
        end
      end

      def destroy
        @menu = MenuDish.find(params[:id])
        render json: {status: 'ok deleted'}, status: 200 if @menu.destroy
      end

      def change_active
        @menu = current_restaurant.menus.find(params[:id])
        if @menu
          current_restaurant.menus.update_all(is_active: false)
          @menu.update(is_active: true)
          render json: @menu, status: 200
        else
          render json: @menu.errors, status: 422
        end
      end

      private

      def menu_params
        params.require(:menu).permit(:name, :restaurant_id, :is_active)
      end

    end
  end
end

