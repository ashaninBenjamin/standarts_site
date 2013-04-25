#coding: utf-8
class ProfilesController < ApplicationController
  skip_before_filter :authenticate!, only: [:new, :create]
  skip_before_filter :registration_passed!, only: [:new, :create]

  def new
    @profile = Profile.new
  end

  def create
    @profile = current_user.build_profile(params[:profile])
    if @profile.save
      current_user.save
      redirect_to new_user_company_path
      flash_success
    else
      render "new"
    end
  end

  def edit
    @profile = current_user.profile
  end

  def update
    @profile = current_user.profile
    if @profile.update_attributes(params[:profile])
      redirect_to edit_user_profile_path
      flash_success
    else
      render "edit"
    end
  end

  def show
    @profile = current_user.profile
  end

end
