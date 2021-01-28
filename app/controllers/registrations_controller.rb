# frozen_string_literal: true

class RegistrationsController < Devise::RegistrationsController
  skip_before_action :authenticate_request!

  def create
    if User.exists?(email: params[:user][:email])
      render json: {message: "Email existed"}, status: 422
    else
      build_resource(sign_up_params)
      resource.save
      sign_up(resource_name, resource) if resource.persisted?
      render json: resource, status: 200
    end
  end
end
