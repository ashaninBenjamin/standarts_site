#coding: utf-8
class Admin::UserInfosController < ApplicationController
  before_filter :correct_user
  before_filter :authenticate
  # GET /admin/user_infos
  # GET /admin/user_infos.json
  def index
    @all = UserInfo.scoped

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @all }
    end
  end

  # GET /admin/user_infos/1
  # GET /admin/user_infos/1.json
  def show
    @user_info = UserInfo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user_info }
    end
  end

  def destroy
    UserInfo.find(params[:id]).destroy
    redirect_to admin_user_infos_path, notice: "Информация о пользователе была удалена"
  end

  private
  def correct_user
    redirect_to root_path unless current_user.super_admin?
  end
  def authenticate
    deny_access unless signed_in?
  end
end
