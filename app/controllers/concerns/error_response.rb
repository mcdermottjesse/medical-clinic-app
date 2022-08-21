module ErrorResponse
  extend ActiveSupport::Concern

  included do
    around_action :handle_errors
  end

  def handle_errors
    begin
      yield
    rescue ClientException => e
      @error = e
      render partial: "shared/error"
    rescue UserException => e
      @error = e
      render partial: "shared/error"
    rescue => e
      @development_error = e # display error ourput for development only! delete in production
      @error = "Something went wrong. Please try again. If problem persists please contact Site Adminstrator"
      render partial: "shared/error"
    end
  end
end
