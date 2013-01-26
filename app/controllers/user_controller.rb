# coding: utf-8
class UserController < ApplicationController
  before_filter :authenticate, :only => [:index, :edit, :update]
  before_filter :correct_user, :only => [:edit, :update]
  def new
    @user = User.new
    @user_info = UserInfo.new
  end

  def create
    user = User.new(params[:user])
    user.roles_id = Role.find_by_name("admin").id
    user_info = UserInfo.new(params[:user_info])
    if !user_info.save
      flash[:error] = "Что-то пошло не так"
      render "new"
    end
    user.user_info_id = user_info.id
    st_blocks = Block.get_template
    st_points = Point.get_template
    st_blocks.each {|x| x.user_id = 2 }
    st_blocks.each {|x| n = Block.new(x), n.save}
    if user.save
      sign_in user
      flash[:success] = "Регистрация прошла успешно"
      redirect_to user
    else
      render 'new'
    end
  end

  def index
    @users = User.find_all_by_roles_id(Role.find_by_name("admin").id)
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to user_path
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
    @user_info = UserInfo.find(@user.user_info_id)
  end

  def update
    user = User.find(params[:id])
    user_info = user.user_info
    if user.update_attributes params[:user] && user_info.update_attributes(params[:user_info])
      flash[:success] = "Изменения вступили в силу"
      redirect_to user
    else
      render 'edit'
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
