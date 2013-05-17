#coding: utf-8
class Web::Admin::HelpsController < Web::Admin::ApplicationController

  def index
    @helps = Help.web.decorate
  end

  def show
    @help = Help.find(params[:id]).decorate
    @helps = Help.web.decorate
  end

  def new
    @help = Help.new
  end

  def edit
    @help = Help.find(params[:id])
  end

  def create
    @help = Help.new(params[:help])
    if @help.save
      redirect_to admin_help_path(@help)
      flash_success
    else
      render action: :new
    end
  end

  def update
    @help = Help.find(params[:id])
    if @help.update_attributes(params[:help])
      redirect_to admin_help_path(@help)
      flash_success
    else
      render action: :edit
    end
  end

  def destroy
    @help = Help.find(params[:id])
    @help.destroy
    redirect_to admin_helps_path
    flash_notice
  end

end
