# coding: utf-8
class Web::UsersController < Web::ApplicationController
  skip_before_filter :authenticate!, only: [:new, :create]
  skip_before_filter :registration_passed!, only: [:new, :create]

  def new
    @user = UserCreateEditType.new
  end

  def create
    @user = UserCreateEditType.new(params[:user])
    @user.role = Role.admin_roles.first
    if @user.save
      sign_in @user
      redirect_to new_user_profile_path
      flash_success
    else
      render action: :new
    end
  end

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = UserCreateEditType.find(current_user)
    if @user.update_attributes(params[:user])
      redirect_to edit_user_path
      flash_success
    else
      render action: :edit
    end
  end

  def destroy
    user = current_user
    user.destroy
    sign_out
    redirect_to new_session_path
    flash_notice
  end

end
