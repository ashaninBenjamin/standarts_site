#coding: utf-8
class NewsController < ApplicationController
  # GET /news
  def index
    @news = News.by_created_at
  end

  # GET /news/1
  def show
    @news = News.find(params[:id])
  end

end
