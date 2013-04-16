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
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def current_user?(user)
    user == current_user
  end

  def deny_access
    redirect_to new_session_path, :notice => "Пожалуйста, авторизируйтесь"
  end

  def finish_sign_up
    redirect_to (current_user.profile) ? new_user_company_path : new_user_profile_path, flash: {error: "Пройдите регистрацию до конца!"}
  end
end
