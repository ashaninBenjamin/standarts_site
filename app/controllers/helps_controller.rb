#coding: utf-8
class HelpsController < ApplicationController
  before_filter :authenticate
  before_filter :correct_user, only: [:edit, :update, :new, :create, :destroy]

  def index
    @all = Help.scoped
  end

  def new
    @help = Help.new
  end

  def create
    @help = Help.new(params[:help])
    if @help.save
      redirect_to @help, flash: { success: "Справка успешно добавлена" }
    else
      render "new"
    end
  end

  def show
    @it = Help.find(params[:id])
    @all = Help.scoped
  end

  def edit
    @help = Help.find(params[:id])
  end

  def update
    @help = Help.find(params[:id])
    if @help.update_attributes(params[:help])
      redirect_to @help, flash: {success: "Справка успешно обновлёна"}
    else
      render "edit"
    end
  end

  def destroy
    Help.find(params[:id]).destroy
    redirect_to helps_path, notic: "Справка успешно удалёна"
  end

  private
  def authenticate
    deny_access unless signed_in?
  end

  def correct_user
    redirect_to helps_path unless current_user_super_admin?
  end
end
