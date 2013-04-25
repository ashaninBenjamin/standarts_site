#coding: utf-8
class Admin::NewsController < Admin::ApplicationController
  # GET /news
  # GET /news.json
  def index
    @news = News.by_created_at
  end

  # GET /news/1
  # GET /news/1.json
  def show
    @news = News.find(params[:id])
  end

  # GET /news/new
  # GET /news/new.json
  def new
    @news = News.new
  end

  # GET /news/1/edit
  def edit
    @news = News.find(params[:id])
  end

  # POST /news
  # POST /news.json
  def create
    @news = News.new(params[:news])
    if @news.save
      redirect_to admin_news_path(@news)
      flash_success
    else
      render action: "new"
    end
  end

# PUT /news/1
# PUT /news/1.json
  def update
    @news = News.find(params[:id])
    if @news.update_attributes(params[:news])
      redirect_to admin_news_path(@news)
      flash_success
    else
      render action: "edit"
    end
  end

# DELETE /news/1
# DELETE /news/1.json
  def destroy
    @news = News.find(params[:id])
    @news.destroy
    flash_notice
  end

end
