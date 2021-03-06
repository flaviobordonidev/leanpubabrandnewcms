class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_locale

  # Devise after signout
  # https://github.com/plataformatec/devise/wiki/How-To:-redirect-to-a-specific-page-on-successful-sign_in,-sign_out,-and-or-sign_up
  # https://github.com/plataformatec/devise/wiki/How-To:-Redirect-to-a-specific-page-on-successful-sign-in-out
  def after_sign_out_path_for(resource_or_scope)
    homepage_path
  end

  #-----------------------------------------------------------------------------
  private
  
  #set language for internationalization
  def set_locale
    I18n.locale = params[:locale] if params[:locale].present?
                # "en"
                # params[:locale] if params[:locale].present?
                # current_user.locale
                # request.subdomain
                # request.env["HTTP_ACCEPT_LANGUAGE"]
                # request.remote_ip
  end
end
