#coding: utf-8
class Web::NewsController < Web::ApplicationController

  def index
    @news = News.web
  end

  def show
    @news = News.find(params[:id])
  end

end
