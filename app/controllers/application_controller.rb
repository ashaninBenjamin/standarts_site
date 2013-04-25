class ApplicationController < ActionController::Base
  before_filter :update_session_history, if: :signed_in?
  protect_from_forgery
  include AuthHelper
  include FlashHelper

  helper_method :signed_in?, :current_user

  private

  def update_session_history
    @history = SessionHistory.find_or_initialize_by_user_id_and_ip(current_user.id, request.remote_ip, page: request.fullpath)
    if @history.new_record?
      @history.save
    else
      @history.update_attribute(:page, request.fullpath)
    end
  end

  def authenticate
    deny_access unless signed_in?
  end

  def correct_user
    finish_sign_up if !current_user.correct?
  end
end
