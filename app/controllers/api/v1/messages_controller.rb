module Api
  module V1
    class MessagesController < ApplicationController

      def index
        @messages = Message.all
        render json: @messages, status: 200
      end

      def new
        @message = Message.new
      end

      def create
        @message = Message.new(message_params)

        if @message.save
          MessageMailer.with(message: @message).new_message_email.deliver_later
        else

        end
      end

      def destroy
        @message = Message.find(params[:id])

        if @message.destroy
          render json: {status: "deleted"}
        end
      end

      private

      def message_params
        params.require(:message).permit(:name, :email, :message)
      end
    end
  end
end
