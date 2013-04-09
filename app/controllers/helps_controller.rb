#coding: utf-8
class HelpsController < ApplicationController

  def index
    @helps = Help.sorted
  end

  def show
    @help = Help.find(params[:id])
    @helps = Help.sorted
  end


end
