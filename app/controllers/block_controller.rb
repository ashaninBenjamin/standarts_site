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
    updateBlock =  Block.find_by_number_and_user_id(params[:number], current_user)
    if params[:block][:content] == "<br />\r\n"
      params[:block][:content] = nil
    end
    if updateBlock.update_attributes(params[:block])
      flash[:success] = "Изменения вступили в силу"
      redirect_to block_path(params[:block][:number])
    else
      render block_index_path
    end
  end

  def clear
    block = Block.find_by_number_and_user_id(params[:number], current_user)
    block.content = nil
    if block.save
      flash[:success] = "Содержание блока очищено"
      redirect_to block_path(params[:number])
    else
      flash[:error] = "Что-то пошло не так, попробуйте ещё раз"
      redirect_to block_edit_path(params[:number])
    end
  end

  private

  def authenticate
    deny_access unless signed_in?
  end
end
