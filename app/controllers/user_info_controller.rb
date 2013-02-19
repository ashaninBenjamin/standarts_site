#coding: utf-8
class UserInfoController < ApplicationController
  before_filter :authenticate, :only => [:index, :edit, :update]
  before_filter :have_access, :only => [:index]
  before_filter :correct_user, :only => [:edit, :update]

  def index
    @all = UserInfo.all
  end

  def new
    @new = UserInfo.new
    @user_id = params[:user_id]
  end

  def create
    new = UserInfo.new(params[:user_info])
    @new = new
    if new.save
      flash[:success] = "Успешно добавлена информация о пользователе"
      if (!params[:user_id].blank?)
        user = User.find(params[:user_id])
        user.update_attribute(:user_info_id, new.id)
        redirect_to new_company_path(:user_id => user.id)
      else
        redirect_to new_company_path
      end
    else
      render "new"
    end
  end

  def edit
    @edit = UserInfo.find(params[:id])
    @user = User.find_by_user_info_id(@edit)
  end

  def update
    upd = UserInfo.find(params[:id])
    @edit = upd
    @user = User.find_by_user_info_id(@edit)
    if upd.update_attributes(params[:user_info])
      flash[:success] = "Обновление прошло успешно"
      redirect_to edit_user_info_path(upd.id)
    else
      render "edit"
    end
  end

  def show
    @user_info = UserInfo.find(params[:id])
  end

  def destroy

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
