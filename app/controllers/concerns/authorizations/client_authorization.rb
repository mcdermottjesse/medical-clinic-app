module Authorizations::ClientAuthorization
  extend ActiveSupport::Concern

  included do
    before_action :authorize_client_resource, if: :clients_controller?
  end

  def authorize_client_resource
    authorize [:client]
  end

  def clients_controller?
    params[:controller].include? "clients"
  end
end