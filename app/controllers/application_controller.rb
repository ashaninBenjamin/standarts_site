class ApplicationController < ActionController::Base
  before_filter :update_session_history
  protect_from_forgery
  include AuthHelper
  include FlashHelper

  helper_method :signed_in?, :current_user

  private

  def update_session_history
    if signed_in?
      @history = SessionHistory.find_by_user_id_and_ip(current_user, request.remote_ip)
      if @history.blank?
        SessionHistory.create(user_id: current_user.id, page: request.fullpath, ip: request.remote_ip)
      else
        @history.update_attribute(:page, request.fullpath) unless request.fullpath.eql?("/session")
      end
    end
  end

  def authenticate
    deny_access unless signed_in?
  end

  def correct_user
    finish_sign_up if !current_user.correct?
  end
end
