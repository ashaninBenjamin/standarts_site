#coding: utf-8
class NewsController < ApplicationController
  before_filter :super_admin
  # GET /news
  # GET /news.json
  def index
    @news = News.by_created_at

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

  def super_admin
    redirect_to admin_news_index_path if current_user.super_admin?
  end

end
