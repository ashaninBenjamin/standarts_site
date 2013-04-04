#coding: utf-8
class UserInfosController < ApplicationController
  before_filter :authenticate, :only => [:index, :edit, :update, :destroy]
  before_filter :have_access, :only => [:index]
  before_filter :correct_user, :only => [:edit, :update, :destroy]

  def index
    @all = UserInfo.scoped
  end

  def new
    @user = User.find(params[:user_id])
    @user_info = UserInfo.new
  end

  def create
    @user_info = UserInfo.new(params[:user_info])
    @user = User.find(params[:user_id])
    if @user_info.save
      @user.update_attribute(:user_info_id, @user_info.id)
      redirect_to new_user_company_path(@user), flash: {success: "Успешно добавлена информация о пользователе"}
    else
      render "new"
    end
  end

  def edit
    @user_info = current_user.user_info
  end

  def update
    @user_info = current_user.user_info
    if @user_info.update_attributes(params[:user_info])
      flash[:success] = "Обновление прошло успешно"
    end
    render "edit"
  end

  def show
    @user_info = UserInfo.find(params[:id])
  end

  def destroy
    UserInfo.find(params[:id]).destroy
    redirect_to user_infos_path, :notice => "Информация о пользователе удалена"
  end

  private
  def authenticate
    deny_access unless signed_in?
  end

  def have_access
    redirect_to root_path unless current_user.super_admin?
  end

  def correct_user
    @user = User.find_by_user_info_id(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end
end
