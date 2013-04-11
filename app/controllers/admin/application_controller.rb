class Admin::ApplicationController < ApplicationController
  before_filter :super_admin
  before_filter :authenticate
  before_filter :correct_user

  private
  def super_admin
    redirect_to root_path unless current_user.super_admin?
  end

end
