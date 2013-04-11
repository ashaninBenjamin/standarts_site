# coding: utf-8
class SessionsController < ApplicationController
  def new
    if signed_in? && current_user.correct?
      redirect_to standards_path
    end
    @type = UserSignInType.new
  end

  def create
    @type = UserSignInType.new(params[:user])

    if @type.valid?
      user = @type.user
      sign_in user
      redirect_to standards_path
    else
      flash.now[:error] = "Неверная пара логин/пароль"
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to new_session_path
  end
end
