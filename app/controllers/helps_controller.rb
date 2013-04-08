#coding: utf-8
class HelpsController < ApplicationController
  before_filter :authenticate
  before_filter :correct_user

  def index
    @helps = Help.scoped
  end

  def show
    @help = Help.find(params[:id])
    @helps = Help.scoped
  end

  private
  def authenticate
    deny_access unless signed_in?
  end

  def correct_user
    redirect_to admin_helps_path if current_user.super_admin?
  end
end
