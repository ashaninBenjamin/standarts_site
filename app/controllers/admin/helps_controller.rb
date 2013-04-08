#coding: utf-8
class Admin::HelpsController < ApplicationController
  before_filter :authenticate
  before_filter :correct_user
  # GET /admin/helps
  # GET /admin/helps.json
  def index
    @helps = Help.sorted

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @helps }
    end
  end

  # GET /admin/helps/1
  # GET /admin/helps/1.json
  def show
    @help = Help.find(params[:id])
    @helps = Help.sorted

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @help }
    end
  end

  # GET /admin/helps/new
  # GET /admin/helps/new.json
  def new
    @help = Help.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @help }
    end
  end

  # GET /admin/helps/1/edit
  def edit
    @help = Help.find(params[:id])
  end

  # POST /admin/helps
  # POST /admin/helps.json
  def create
    @help = Help.new(params[:help])

    respond_to do |format|
      if @help.save
        format.html { redirect_to admin_help_path(@help), flash: { success: "Справка успешно добавлена" } }
        format.json { render json: @help, status: :created, location: @help }
      else
        format.html { render action: "new" }
        format.json { render json: @help.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /admin/helps/1
  # PUT /admin/helps/1.json
  def update
    @help = Help.find(params[:id])

    respond_to do |format|
      if @help.update_attributes(params[:help])
        format.html { redirect_to admin_help_path(@help), {success: "Справка успешно обновлёна"} }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @help.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/helps/1
  # DELETE /admin/helps/1.json
  def destroy
    @help = Help.find(params[:id])
    @help.destroy

    respond_to do |format|
      format.html { redirect_to admin_helps_url }
      format.json { head :no_content }
    end
  end

  private
  def authenticate
    deny_access unless signed_in?
  end

  def correct_user
    redirect_to root_path unless current_user.super_admin?
  end
end
