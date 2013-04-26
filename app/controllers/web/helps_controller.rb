#coding: utf-8
class Web::HelpsController < Web::ApplicationController

  def index
    @helps = Help.by_number.decorate
  end

  def show
    @help = Help.find(params[:id]).decorate
    @helps = Help.by_number.decorate
  end

end