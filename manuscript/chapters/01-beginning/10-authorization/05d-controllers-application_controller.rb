class ApplicationController < ActionController::Base
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
 
  before_action :configure_permitted_parameters, if: :devise_controller?

  # https://www.codementor.io/anuraag.jpr/the-difference-between-public-private-and-protected-methods-in-ruby-6zsvkeeqr
  protected
  
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_in, keys: [:role])
      devise_parameter_sanitizer.permit(:sign_up, keys: [:role])
      devise_parameter_sanitizer.permit(:account_update, keys: [:role])
    end

  private
 
    def user_not_authorized
      redirect_to request.referrer || root_path, notice: "You are not authorized to perform this action."
    end
end
