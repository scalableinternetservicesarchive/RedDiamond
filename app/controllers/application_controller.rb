class ApplicationController < ActionController::Base
  include Pagy::Backend

  skip_forgery_protection
  before_action :configure_devise, if: :devise_controller?

  def not_found
    raise ActionController::RoutingError, 'Not Found'
  end

  protected

  def configure_devise
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end
end
