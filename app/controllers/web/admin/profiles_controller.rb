#coding: utf-8
class Web::Admin::ProfilesController < Web::Admin::ApplicationController
  # GET /admin/user_infos
  # GET /admin/user_infos.json
  def index
    @q = Profile.ransack(params[:q])
    @profiles = ProfileDecorator.decorate_collection @q.result
  end

  # GET /admin/user_infos/1
  # GET /admin/user_infos/1.json
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
