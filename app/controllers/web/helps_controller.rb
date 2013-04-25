#coding: utf-8
class Web::HelpsController < Web::ApplicationController

  def index
    @helps = HelpDecorator.decorate_collection Help.by_number
  end

  def show
    @help = Help.find(params[:id]).decorate
    @helps = HelpDecorator.decorate_collection Help.by_number
  end

end