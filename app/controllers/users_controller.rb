# coding: utf-8
class UsersController < ApplicationController
  before_filter :authenticate, :only => [:index, :edit, :update, :destroy]
  before_filter :correct_user, :only => [:edit, :update, :destroy]

  def index
    @users = User.scoped
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    @user.role = Role.admin_role
    if @user.save
      redirect_to new_user_user_info_path(@user), flash: {success: "Учётная запись зарегистрирована"}
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to edit_user_path(@user), flash: {success: "Изменения вступили в силу"}
    else
      render 'edit'
    end
  end

  def destroy
    user = User.find(params[:id]).destroy
    redirect_to current_user?(user) ? logout_path : users_path, notice: "Пользователь удалён"
  end

  private
  def authenticate
    deny_access unless signed_in?
  end

  #Проверка на не того же пользователя или супер администратора
  def correct_user
    @user = User.find(params[:id])
    redirect_to root_path unless (current_user?(@user) || current_user_super_admin?)
  end
end
