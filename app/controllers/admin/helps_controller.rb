#coding: utf-8
class Admin::HelpsController < Admin::ApplicationController
  # GET /admin/helps
  # GET /admin/helps.json
  def index
    @helps = HelpDecorator.decorate_collection Help.by_number
  end

  # GET /admin/helps/1
  # GET /admin/helps/1.json
  def show
    @help = Help.find(params[:id]).decorate
    @helps = HelpDecorator.decorate_collection Help.by_number
  end

  # GET /admin/helps/new
  # GET /admin/helps/new.json
  def new
    @help = Help.new
  end

  # GET /admin/helps/1/edit
  def edit
    @help = Help.find(params[:id])
  end

  # POST /admin/helps
  # POST /admin/helps.json
  def create
    @help = Help.new(params[:help])
    if @help.save
      redirect_to admin_help_path(@help)
      flash_success
    else
      render action: "new"
    end
  end

  # PUT /admin/helps/1
  # PUT /admin/helps/1.json
  def update
    @help = Help.find(params[:id])
    if @help.update_attributes(params[:help])
      redirect_to admin_help_path(@help)
      flash_success
    else
      render action: "edit"
    end
  end

  # DELETE /admin/helps/1
  # DELETE /admin/helps/1.json
  def destroy
    @help = Help.find(params[:id])
    @help.destroy
    redirect_to admin_helps_path
    flash_notice
  end

end
