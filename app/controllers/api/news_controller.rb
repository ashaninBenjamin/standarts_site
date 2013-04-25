class Api::NewsController < Api::ApplicationController
  def index
    @news = News.scoped
    respond_with @news
  end

  def show
    @news = News.find(params[:id])
    respond_with @news
  end
end