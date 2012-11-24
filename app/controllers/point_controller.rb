# coding: utf-8
class PointController < ApplicationController
  before_filter :authenticate

  def edit
    @code = params[:code]
    #@point = Point.where(:code => @code.gsub("-", "."), :blocks => )
    @point = Point.find_by_code(@code.gsub("-", "."))
  end

  def update
    code = params[:code].gsub("-", ".")
    @standart = Point.find_by_code(code)
    if @standart.update_attributes(params[:point])
      flash[:success] = "Изменения вступили в силу"
      redirect_to :action => "show", :code => params[:code]
    else
      render standarts_path
    end

  end

  def show
    code = params[:code].gsub("-", ".")
    @point = Point.find_by_code(code)
    @txt = @point.content
    @children = Point.find_all_by_parent_id(@point.id)
  end

  def show_by_block
  end

  private

  def authenticate
    deny_access unless signed_in?
  end
end
