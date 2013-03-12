# coding: utf-8
class SessionController < ApplicationController
  def new
    if signed_in?
      redirect_to standard_index_path
    end
  end

  def create
    user = User.authenticate(params[:session][:login],
                             params[:session][:password])
    if user.nil?
      flash.now[:error] = "Неверная пара логин/пароль"
      render 'new'
    elsif user.has_fail_info?
      flash[:error] = "Пройдите регистрацию до конца!"
      redirect_to (!user.user_info) ? new_user_info_path(:user_id => user.id) : new_company_path(:user_id => user.id)
    else
      sign_in user
      #redirect_back_or standard_index_path
      redirect_to standard_index_path
    end
  end

  def destroy
    sign_out
    redirect_to login_path
  end
end
