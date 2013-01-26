# coding: utf-8
class SessionController < ApplicationController
  def new
      if signed_in?
        redirect_to block_index_path
      end
  end

  def create
    user = User.authenticate(params[:session][:login],
                             params[:session][:password])
    @user = user
    if user.nil?
      flash.now[:error] = "Invalid login/password combination."
      render 'new'
    else
      sign_in user
      redirect_back_or block_index_path
    end
  end

  def destroy
    sign_out
    redirect_to signin_path
  end
end
