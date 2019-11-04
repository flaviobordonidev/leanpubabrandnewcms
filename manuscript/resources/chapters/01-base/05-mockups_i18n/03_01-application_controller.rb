class ApplicationController < ActionController::Base
  before_action :set_locale

  #-----------------------------------------------------------------------------
  private
  
  #set language for internationalization
  def set_locale
    I18n.locale = params[:locale] if params[:locale].present?
  end
end
