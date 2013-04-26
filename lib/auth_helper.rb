# coding: utf-8
module AuthHelper
  def sign_in(user)
    session[:user_id] = user.id
  end

  def sign_out
    reset_session
  end

  def signed_in?
    current_user.present?
  end

  def current_user
    user = User.find_by_id(session[:user_id])
    return nil unless user
    @current_user ||= user.decorate
  end

  def current_user?(user)
    user == current_user
  end

  def authenticate!
    redirect_to new_session_path, notice: t("auth_helper.please_authorize") unless signed_in?
  end

  def authorize_admin!
    redirect_to root_path unless current_user.super_admin?
  end

  def registration_passed!
    unless current_user.correct?
      redirect_to (current_user.profile) ? new_user_company_path : new_user_profile_path, flash: {error: t("auth_helper.pass_registration")}
    end
  end
end
