# coding: utf-8
class UsersController < ApplicationController
  before_filter :authenticate, only: [:index, :show, :edit, :update, :destroy]
  before_filter :correct_user, only: [:index, :show, :edit, :update, :destroy]

  def new
    @user = UserCreateType.new
  end

  def create
    @user = UserCreateType.new(params[:user])
    @user.role = Role.admin_roles.first
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
    @user = UserEditType.find(current_user)
    if @user.update_attributes(params[:user])
      redirect_to edit_user_path, flash: {success: "Изменения вступили в силу"}
    else
      render 'edit'
    end
  end

  def destroy
    user = current_user
    user.destroy
    sign_out
    redirect_to new_session_path, notice: "Пользователь удалён"
  end

end
