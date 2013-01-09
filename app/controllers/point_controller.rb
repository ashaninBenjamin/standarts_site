# coding: utf-8
class PointController < ApplicationController
  before_filter :authenticate

  def edit
    @code = params[:code]
    @point = Point.find_by_link_and_user(@code, current_user)
  end

  def update
    standart = Point.find_by_link_and_user(params[:code], current_user)

    if standart.update_attributes(params[:point])
      flash[:success] = "Изменения вступили в силу"
      redirect_to point_path(params[:code])
    else
      render standarts_path
    end

  end

  def show
    @point = Point.find_by_link_and_user(params[:code], current_user)
    @txt = @point.content
    @children = @point.child
  end

  def show_by_block
  end

  private

  def authenticate
    deny_access unless signed_in?
  end
end
