class ApplicationController < ActionController::Base
  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?

  include Pundit

  #def after_sign_in_path_for(resource_or_scope)
  #  #current_user # goes to users/1 (if current_user = 1)
  #  #users_path #goes to users/index
  #  eg_posts_path #goes to eg_posts/index
  #end

  #-----------------------------------------------------------------------------
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_in)
    devise_parameter_sanitizer.permit(:sign_up)
    devise_parameter_sanitizer.permit(:account_update)

    #devise_parameter_sanitizer.permit(:sign_in, keys: [:language])
    #devise_parameter_sanitizer.permit(:sign_up, keys: [:language])
    #devise_parameter_sanitizer.permit(:account_update, keys: [:language])

    #devise_parameter_sanitizer.permit(:sign_in, keys: [:role, :name, :language])
    #devise_parameter_sanitizer.permit(:sign_up, keys: [:role, :name, :language])
    #devise_parameter_sanitizer.permit(:account_update, keys: [:role, :name, :language])
  end
  
  #-----------------------------------------------------------------------------
  private
  
    #set language for internationalization
    def set_locale
      if user_signed_in?
        #I18n.locale = current_user.language
        params[:locale] = current_user.language if params[:locale].blank?
      else
        #raise "params[:locale] = #{params[:locale].present?}"
        #raise "params[:locale] = #{params[:locale].blank?}"
        # Se non ho assegnato il parametro :locale allora gli passo la lingua impostata sul browser 
        # (per testare usa Google chrome Extension: Locale Switcher)
        params[:locale] = request.env.fetch('HTTP_ACCEPT_LANGUAGE', '').scan(/[a-z]{2}/).first if params[:locale].blank?
        #raise "params[:locale] = #{params[:locale]}"
      end
  
      case params[:locale]
      when "it", "en"
        I18n.locale = params[:locale]
      else
        I18n.locale = I18n.default_locale
      end
    end
end
