# frozen_string_literal: true

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

        MessageMailer.with(message: @message).new_message_email.deliver_later if @message.save
      end

      def destroy
        @message = Message.find(params[:id])

        render json: { status: 'deleted' } if @message.destroy
      end

      private

      def message_params
        params.require(:message).permit(:name, :email, :message)
      end
    end
  end
end
