class ApplicationController < ActionController::Base
  before_filter :update_session_history
  protect_from_forgery
  include SessionHelper

  I18n.default_locale = :ru
  I18n.locale = :ru

  private
  def update_session_history
    if signed_in?
      @history = SessionHistory.find_by_ip(request.remote_ip)
      if @history.blank?
        SessionHistory.create(user_id: current_user.id, page: request.fullpath, ip: request.remote_ip)
      else
        @history.update_attributes(user_id: current_user.id, page: request.fullpath)
      end
    end
  end
end
