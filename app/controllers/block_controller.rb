# coding: utf-8
class BlockController < ApplicationController
  def index
    @blocks = Block.find_all_by_user_id(current_user.id)
  end

  def show
    @block = Block.find_by_number_and_user_id(params[:number], current_user)
    @points = Point.find_all_by_block_id(@block.id)
  end

  def edit
    @block = Block.find_by_number_and_user_id(params[:number], current_user)
  end

  def update
    updateBlock = Block.find_by_number_and_user_id(params[:number], current_user)
    if updateBlock.update_attributes(params[:block])
      flash[:success] = "Изменения вступили в силу"
      redirect_to block_path(params[:number])
    else
      render block_index_path
    end
  end

  private

  def authenticate
    deny_access unless signed_in?
  end
end
