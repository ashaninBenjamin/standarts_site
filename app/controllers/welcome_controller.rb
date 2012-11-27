# coding: utf-8
class WelcomeController < ApplicationController
  before_filter :authenticate

  def index
      @blocks = Block.find_all_by_user_id(current_user.id)
  end

  def point
    code = params[:code].gsub("-", ".")
    @point = Point.find_by_code(code)
    @txt = @point.content
    @children = Point.find_all_by_parent_id(@point.id)
  end

  def edit
    @code = params[:code]
    @point = Point.find_by_code(@code.gsub("-", "."))
  end

  def update
    code = params[:code].gsub("-", ".")
    @standart = Point.find_by_code(code)
    if @standart.update_attributes(params[:point])
      flash[:success] = "Изменения вступили в силу"
      redirect_to :action => "point", :code => params[:code]
    else
      render 'index'
    end

  end

  def test
    #@txt = params[:par]
    pp = Point.find_by_code(params[:par].gsub("-","."))
    @txt = levelPoint(pp)
  end

  def block
    @block = Block.find(params[:id])
    @points = Point.find_all_by_block_id(@block.id)
  end

  def blockEdit
    @block = Block.find(params[:id])
  end

  def blockUpdate
    updateBlock = Block.find(params[:id])
    if updateBlock.update_attributes(params[:block])
      flash[:success] = "Изменения вступили в силу"
      redirect_to :action => "block", :id => params[:id]
    else
      render 'index'
    end
  end

  def update_songs
    # updates songs based on artist selected
    points = Point.find(params[:block_id])

    render :update do |page|
      page.replace_html 'points', :partial => 'points', :object => points
    end
  end

  private

  def authenticate
    deny_access unless signed_in?
  end
end
