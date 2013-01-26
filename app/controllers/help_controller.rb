#coding: utf-8
class HelpController < ApplicationController
  def index
    @all = Help.all
  end

  def new
    @new = Help.new
  end

  def create
    new = Help.new(params[:new])
    if new.save
      flash[:success] = "Успешно добавлен раздел"
      redirect_to help_path(new)
    else
      flash[:error] = "Что-то пошло не так"
      render "new"
    end
  end

  def show
    @it = Help.find params[:id]
    @all = Help.all
  end

  def edit
    @edit = Help.find params[:id]
  end

  def update
    upd = Help.find params[:id]
    if upd.update_attributes(params[:edit])
      flash[:success] = "Справка успешно обновлёна"
      redirect_to help_path(upd)
    else
      flash[:error] = "Что-то пошло не так"
      render "edit"
    end
  end

  def destroy
    Help.find(params[:id]).destroy
    flash[:notice] = "Справка успешно удалёна"
    redirect_to help_index_path
  end
end
