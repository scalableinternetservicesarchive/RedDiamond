class ApplicationController < ActionController::Base
  before_action :configure_devise, if: :devise_controller?

  protected

  def configure_devise
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end
end
