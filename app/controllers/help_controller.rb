#coding: utf-8
class HelpController < ApplicationController
  def index
    @all = Help.all
  end

  def new
    @new = Help.new
  end

  def create
    new = Help.new(params[:help])
    @new = new
    if new.save
      flash[:success] = "Справка успешно добавлена"
      redirect_to help_path(new)
    else
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
    @edit = upd
    if upd.update_attributes(params[:help])
      flash[:success] = "Справка успешно обновлёна"
      redirect_to help_path(upd)
    else
      render "edit"
    end
  end

  def destroy
    Help.find(params[:id]).destroy
    flash[:notice] = "Справка успешно удалёна"
    redirect_to help_index_path
  end
end
