module Authorizations::UserAuthorization
  extend ActiveSupport::Concern

  included do
    # -> is a shorthand version of writing lambda
    before_action :authorize_resource, if: -> { users_controller? || invitaions_controller? && user_signed_in? }
    # checking if signed in to allow new user to set new password
  end

  private

  def authorize_resource
    authorize [:admin, :user]
  end

  def users_controller?
    params[:controller].include? "users"
  end

  def invitaions_controller?
    params[:controller].include? "invitations"
  end
end
