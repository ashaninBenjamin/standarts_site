#coding: utf-8
class Web::HelpsController < Web::ApplicationController

  def index
    @helps = Help.web.decorate
  end

  def show
    @help = Help.find(params[:id]).decorate
    @helps = Help.web.decorate
  end

end