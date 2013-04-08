#coding: utf-8
class NewsController < ApplicationController
  before_filter :authenticate
  before_filter :correct_user
  # GET /news
  # GET /news.json
  def index
    @news = News.sorted

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @news }
    end
  end

  # GET /news/1
  # GET /news/1.json
  def show
    @news = News.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @news }
    end
  end

  private
  def authenticate
    deny_access unless signed_in?
  end

  def correct_user
    redirect_to admin_news_index_path if current_user.super_admin?
  end
end
