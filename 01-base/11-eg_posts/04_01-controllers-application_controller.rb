class ApplicationController < ActionController::Base
  before_action :set_locale
  before_action :store_user_location!, if: :storable_location?
  # The callback which stores the current location must be added before you authenticate the user 
  # as `authenticate_user!` (or whatever your resource is) will halt the filter chain and redirect 
  # before the location can be stored.
  #before_action :authenticate_user! # Questa riga protegge tutta l'applicazione. Noi la usiamo sui vari controllers.

  def after_sign_in_path_for(resource_or_scope)
    #current_user # goes to users/1 (if current_user = 1)
    #users_path #goes to users/index
    #eg_posts_path
    stored_location_for(resource_or_scope) || super
  end

  #keep internationalization through links
  def default_url_options
    { locale: I18n.locale }
  end

  #-----------------------------------------------------------------------------
  private
  
  #set language for internationalization
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
  #def set_locale
  #  I18n.locale = params[:locale] if params[:locale].present?
  #end

  # Its important that the location is NOT stored if:
  # - The request method is not GET (non idempotent)
  # - The request is handled by a Devise controller such as Devise::SessionsController as that could cause an 
  #    infinite redirect loop.
  # - The request is an Ajax request as this can lead to very unexpected behaviour.
  def storable_location?
    request.get? && is_navigational_format? && !devise_controller? && !request.xhr? 
  end

  def store_user_location!
    # :user is the scope we are authenticating
    store_location_for(:user, request.fullpath)
  end

end
