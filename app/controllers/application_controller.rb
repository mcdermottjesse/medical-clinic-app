class ApplicationController < ActionController::Base
  before_action :authenticate_user!, :filter_params
  before_action :configure_permitted_parameters, if: :devise_controller?

  include Pundit::Authorization
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected

  def filter_params
    @location_param = params[:location]
  end

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_back(fallback_location: authenticated_root_path)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:accept_invitation, keys: [:first_name, :last_name, :email, :password, :password_confirmation])
  end
end
