class ApplicationController < ActionController::Base
  before_action :authenticate_user!, :filter_params, except: [:not_found]
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :valid_user, if: :user_signed_in?

  include Pundit::Authorization
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  include Authorizations::UserAuthorization, Authorizations::ClientAuthorization

  include Errors::ErrorResponse

  protected

  def filter_params
    @location_param = params[:location]
  end

  def user_not_authorized
    flash[:alert] = 'You are not authorized to perform this action.'
    redirect_back(fallback_location: authenticated_root_path)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:accept_invitation, keys: [:first_name, :last_name, :email, :password, :password_confirmation])
  end

  def valid_user
    @valid_user = current_user.account_type == "Admin" || current_user.account_type == "Manager"
  end
end
