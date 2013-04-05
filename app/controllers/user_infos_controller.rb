#coding: utf-8
class UserInfosController < ApplicationController
  before_filter :authenticate, :only => [:edit, :update, :destroy]

  def new
    @user_info = UserInfo.new
  end

  def create
    @user_info = UserInfo.new(params[:user_info])
    user = get_temp_user
    if @user_info.save
      user.update_attribute(:user_info_id, @user_info.id)
      redirect_to new_user_company_path, flash: {success: "Успешно добавлена информация о пользователе"}
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
    @user_info = current_user.user_info
  end

  private
  def authenticate
    deny_access unless signed_in?
  end
end
