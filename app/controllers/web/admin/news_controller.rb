#coding: utf-8
class Web::Admin::NewsController < Web::Admin::ApplicationController

  def index
    @news = News.by_created_at
  end

  def show
    @news = News.find(params[:id])
  end

  def new
    @news = News.new
  end

  def edit
    @news = News.find(params[:id])
  end

  def create
    @news = News.new(params[:news])
    if @news.save
      redirect_to admin_news_path(@news)
      flash_success
    else
      render action: "new"
    end
  end

  def update
    @news = News.find(params[:id])
    if @news.update_attributes(params[:news])
      redirect_to admin_news_path(@news)
      flash_success
    else
      render action: "edit"
    end
  end

  def destroy
    @news = News.find(params[:id])
    @news.destroy
    redirect_to admin_news_index_path
    flash_notice
  end

end
