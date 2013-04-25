#coding: utf-8
class Admin::UsersController < Admin::ApplicationController
  # GET /admin/users
  # GET /admin/users.json
  def index
    @q = User.ransack(params[:q])
    @users = UserDecorator.decorate_collection @q.result(distinct: true)
  end

  # GET /admin/users/1
  # GET /admin/users/1.json
  def show
    @user = User.find(params[:id])
  end

  # DELETE /admin/users/1
  # DELETE /admin/users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path
    flash_notice
  end

end
