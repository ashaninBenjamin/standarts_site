# coding: utf-8
class UserController < ApplicationController
  before_filter :authenticate, :only => [:index, :edit, :update]
  before_filter :correct_user, :only => [:edit, :update]

  def index
    @users = User.find_all_by_roles_id(Role.find_by_name("admin").id)
  end

  def new
    @user = User.new
  end

  def create
    user = User.new(params[:user])
    user.role = Role.admin_role
    @user = user
    if user.save
      flash[:success] = "Учётная запись зарегистрирована"
      redirect_to new_user_info_path(:user_id => user.id)
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
    user = User.find(params[:id])
    @user = user
    if user.update_attributes params[:user]
      flash[:success] = "Изменения вступили в силу"
      redirect_to edit_user_path(user)
    else
      render 'edit'
    end
  end

  def destroy
    user = User.find(params[:id]).destroy
    flash[:success] = "Пользователь удалён"
    if (user.eql?(current_user))
      redirect_to logout_path
    else
      redirect_to root_path
    end
  end

  private

    def authenticate
      deny_access unless signed_in?
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
end
