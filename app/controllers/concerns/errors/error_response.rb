module Errors::ErrorResponse
  extend ActiveSupport::Concern

  included do
    around_action :internal_server_error
  end
  
  # this handles 500 internal server errors

  def internal_server_error
    begin
      yield
    rescue Errors::ClientException => e
      @error = e
      render "errors/internal_server_error"
    rescue Errors::UserException => e
      @error = e
      render "errors/internal_server_error"
    rescue => e
      @development_error = e # display error ourput for development only! delete in production?
      render "errors/internal_server_error"
    end
  end
end
