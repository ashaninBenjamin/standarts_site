# coding: utf-8
class SessionController < ApplicationController
  def new
    if signed_in?
      redirect_to standards_path
    end
  end

  def create
    user = User.authenticate(params[:session][:login],
                             params[:session][:password])
    if user.nil?
      flash.now[:error] = "Неверная пара логин/пароль"
      render 'new'
    elsif user.has_fail_info?
      redirect_to (!user.user_info) ? new_user_user_info_path(user) : new_user_company_path(user), flash: {error: "Пройдите регистрацию до конца!"}
    else
      sign_in user
      redirect_to standards_path
    end
  end

  def destroy
    sign_out
    redirect_to login_path
  end
end
