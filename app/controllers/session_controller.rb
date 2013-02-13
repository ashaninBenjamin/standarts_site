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
    else
      sign_in user
      redirect_back_or standard_index_path
    end
  end

  def destroy
    sign_out
    redirect_to login_path
  end
end
