class ApplicationController < ActionController::Base
  before_action :set_locale

  #-----------------------------------------------------------------------------
  private

    def default_url_options(options = {})
      {locale: I18n.locale}
    end
  
    #set language for internationalization
    def set_locale
      
      #raise "params[:locale] = #{params[:locale].present?}"
      #raise "params[:locale] = #{params[:locale].blank?}"
      # Se non ho assegnato il parametro :locale allora gli passo la lingua impostata sul browser 
      # (per testare usa Google chrome Extension: Locale Switcher)
      params[:locale] = request.env.fetch('HTTP_ACCEPT_LANGUAGE', '').scan(/[a-z]{2}/).first if params[:locale].blank?
      #raise "params[:locale] = #{params[:locale]}"

      case params[:locale]
      when "it", "en"
        I18n.locale = params[:locale]
      else
        I18n.locale = I18n.default_locale
      end
    end
end
