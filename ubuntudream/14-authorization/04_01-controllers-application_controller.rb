class ApplicationController < ActionController::Base
  before_action :set_locale

  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  include Pagy::Backend

  #-----------------------------------------------------------------------------
  private

    #keep the locale through links
    def default_url_options(options = {})
      {locale: I18n.locale}
    end

    #set language for internationalization
    def set_locale
      # Se non ho assegnato il parametro :locale allora gli passo la lingua impostata sul browser
      # (per testare usa Google chrome Extension: Locale Switcher)
      params[:locale] = request.env.fetch('HTTP_ACCEPT_LANGUAGE', '').scan(/[a-z]{2}/).first if params[:locale].blank?
      case params[:locale]
      when "it", "en"
        I18n.locale = params[:locale]
      else
        I18n.locale = I18n.default_locale
      end
    end

    # Pundit rescue_from
    def user_not_authorized
      redirect_to request.referrer || root_path, notice: t("pundit.you_are_not_authorized")
    end
end
