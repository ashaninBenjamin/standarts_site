# coding: utf-8
class StandardController < ApplicationController
  before_filter :authenticate
  def index
    @all = Standard.find_all_with_user(current_user)
  end

  def new
    @new = Standard.new
  end

  def create
    new = Standard.new(params[:new])
    new.user_id = current_user.id
    if new.save
      flash[:success] = "Успешно добавлен раздел"
      redirect_to standard_path(new.link)
    else
      flash[:error] = "Не все нужные поля были заполнены"
      render "new"
    end
  end

  def edit
    @edit = Standard.find_by_link(params[:id], current_user)
  end

  def update
    upd = Standard.find_by_link(params[:id], current_user)
    if upd.update_attributes(params[:edit])
      flash[:success] = "Раздел успешно обновлён"
      redirect_to standard_path(upd.link)
    else
      flash[:error] = "Что-то пошло не так"
      render "edit"
    end
  end

  def show
    @it = Standard.find_by_link(params[:id], current_user)
  end

  def destroy
    Standard.find_by_link(params[:id], current_user).destroy
    flash[:notice] = "Раздел успешно удалён"
    redirect_to standard_index_path
  end

  private
  def authenticate
    deny_access unless signed_in?
  end
end
