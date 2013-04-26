#coding: utf-8
class Web::Admin::UsersController < Web::Admin::ApplicationController

  def index
    @q = User.ransack(params[:q])
    @users = @q.result.decorate
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path
    flash_notice
  end

end
