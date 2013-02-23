class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_locale
  before_filter :authenticate_user!
  
  def set_locale
    I18n.locale = "ru"#params[:locale]
  end
end
