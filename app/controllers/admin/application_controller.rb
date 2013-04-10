class Admin::ApplicationController < ApplicationController
  before_filter :correct_user
  before_filter :authenticate
  include SessionHelper

  private
  def correct_user
    redirect_to root_path unless current_user.super_admin?
  end
  def authenticate
    deny_access unless signed_in?
  end

end
