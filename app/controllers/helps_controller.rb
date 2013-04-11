#coding: utf-8
class HelpsController < ApplicationController
  before_filter :super_admin

  def index
    @helps = Help.sorted
  end

  def show
    @help = Help.find(params[:id])
    @helps = Help.sorted
  end

  private

  def super_admin
    redirect_to admin_news_index_path if current_user.super_admin?
  end

end