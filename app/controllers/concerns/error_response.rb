module ErrorResponse
  extend ActiveSupport::Concern

  included do
    around_action :handle_errors
  end
  # this handles 500 internal server errors
  # may need to create a new controller for 404 page not found errors - reference https://mattbrictson.com/dynamic-rails-error-pages
  def handle_errors
    begin
      yield
    rescue ClientException => e
      @error = e
      render "errors/error"
    rescue UserException => e
      @error = e
      render "errors/error"
    rescue => e
      @development_error = e # display error ourput for development only! delete in production
      @error = "Something went wrong. Please try again. If problem persists please contact Site Adminstrator"
      render "errors/error"
    end
  end
end
