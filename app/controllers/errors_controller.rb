class ErrorsController < ApplicationController
  # controller for 404 page not found errors - reference https://mattbrictson.com/dynamic-rails-error-pages
  def not_found
    user_signed_in? ? @error_link_text = 'Back to Home' : @error_link_text = 'Log in to continue'
    render(status: 404)
  end
end