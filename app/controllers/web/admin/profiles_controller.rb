#coding: utf-8
class Web::Admin::ProfilesController < Web::Admin::ApplicationController

  def index
    @q = Profile.ransack(params[:q])
    @profiles = @q.result.decorate
  end

  def show
    @profile = Profile.find(params[:id])
  end

  def destroy
    profile = Profile.find(params[:id])
    profile.destroy
    redirect_to admin_profiles_path
    flash_notice
  end

end
