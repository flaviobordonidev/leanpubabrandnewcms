class ApplicationController < ActionController::Base
  before_action :set_locale

  #-----------------------------------------------------------------------------
  private
  
  #set language for internationalization
  def set_locale
    case params[:locale]
    when "it", "en"
      I18n.locale = params[:locale]
    else
      I18n.locale = I18n.default_locale
    end
  end
end
