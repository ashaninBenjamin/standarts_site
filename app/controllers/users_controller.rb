# coding: utf-8
class UsersController < ApplicationController
  before_filter :authenticate, :only => [:show, :edit, :update, :destroy]

  def new
    @user = UserType.new
  end

  def create
    @user = UserType.new(params[:user])
    @user.role = Role.admin_role
    if @user.save
      sign_in @user
      redirect_to new_user_profile_path, flash: {success: "Учётная запись зарегистрирована"}
    else
      render 'new'
    end
  end

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = UserType.find(current_user)
    if @user.update_attributes(params[:user])
      redirect_to edit_user_path, flash: {success: "Изменения вступили в силу"}
    else
      render 'edit'
    end
  end

  def destroy
    user = current_user
    user.destroy
    redirect_to logout_path, notice: "Пользователь удалён"
  end

  private
  def authenticate
    deny_access unless signed_in?
  end
end
