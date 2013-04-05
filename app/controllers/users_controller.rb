# coding: utf-8
class UsersController < ApplicationController
  before_filter :authenticate, :only => [:edit, :update, :destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    @user.role = Role.admin_role
    if @user.save
      set_temp_user @user
      redirect_to new_user_user_info_path, flash: {success: "Учётная запись зарегистрирована"}
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
    @user = current_user
    if @user.update_attributes(params[:user])
      flash[:success] = "Изменения вступили в силу"
    end
    render 'edit'
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
