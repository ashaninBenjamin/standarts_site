class ApplicationController < ActionController::Base
  before_filter :update_session_history
  protect_from_forgery
  include SessionHelper

  private
  def update_session_history
    if signed_in?
      @history = SessionHistory.find_by_user_id_and_ip(current_user, request.remote_ip)
      if @history.blank?
        SessionHistory.create(user_id: current_user.id, page: request.fullpath, ip: request.remote_ip)
      else
        @history.update_attribute(:page, request.fullpath) unless request.fullpath.eql?("/logout")
      end
    end
  end
end
