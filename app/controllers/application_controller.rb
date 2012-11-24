class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionHelper

  I18n.default_locale = :ru
  I18n.locale = :ru
end
