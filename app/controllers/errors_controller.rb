class ErrorsController < ApplicationController
  # controller for 404 page not found errors - reference https://mattbrictson.com/dynamic-rails-error-pages
  def not_found
    render(:status => 404)
  end
end