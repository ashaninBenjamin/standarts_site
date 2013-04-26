#coding: utf-8
class Web::NewsController < Web::ApplicationController

  def index
    @news = News.by_created_at
  end

  def show
    @news = News.find(params[:id])
  end

end
