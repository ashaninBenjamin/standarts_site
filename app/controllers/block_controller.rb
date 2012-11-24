# coding: utf-8
class BlockController < ApplicationController
  def index
    @blocks = Block.find_all_by_user_id(current_user.id)
    #@blocks = @blocks.sort_by(:order => :nu)
  end

  def show
    @block = Block.where(:number => params[:number], :user_id => current_user.id).first

    @points = Point.find_all_by_block_id(@block.id)
  end

  def edit
    @block = Block.where(:number => params[:number], :user_id => current_user.id).first
  end

  def update
    updateBlock = Block.where(:number => params[:number], :user_id => current_user.id).first
    if updateBlock.update_attributes(params[:block])
      flash[:success] = "Изменения вступили в силу"
      redirect_to block_path(params[:number])
    else
      render standarts_path
    end
  end

  private

  def authenticate
    deny_access unless signed_in?
  end
end
