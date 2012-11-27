# coding: utf-8
class PointController < ApplicationController
  before_filter :authenticate

  def edit
    @code = params[:code]
    @point = Point.where("code = ? AND block_id IN (?)", @code.gsub("-", "."), Block.find_all_by_user_id(current_user.id)).first
    #@point = Point.find_by_code(@code.gsub("-", "."))
  end

  def update
    code = params[:code].gsub("-", ".")
    @standart = Point.where("code = ? AND block_id IN (?)", code, Block.find_all_by_user_id(current_user.id)).first
    if @standart.update_attributes(params[:point])
      flash[:success] = "Изменения вступили в силу"
      redirect_to point_path(params[:code])
    else
      render standarts_path
    end

  end

  def show
    code = params[:code].gsub("-", ".")
    @point = Point.where("code = ? AND block_id IN (?)", code.gsub("-", "."), Block.find_all_by_user_id(current_user.id)).first
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
