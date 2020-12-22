class ApplicationController < ActionController::Base
  # before_action :authenticate_user!
  protect_from_forgery with: :null_session

  include ApplicationHelper

  def render_jsonapi_response(resource)
    if resource.errors.empty?
      render json: resource
    else
      render json: resource.errors, status: 400
    end
  end
end
