#coding: utf-8
class Admin::CompaniesController < ApplicationController
  before_filter :correct_user
  before_filter :authenticate
  # GET /admin/companies
  # GET /admin/companies.json
  def index
    @all = Company.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @all }
    end
  end

  # GET /admin/companies/1
  # GET /admin/companies/1.json
  def show
    @company = Company.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @company }
    end
  end

  def destroy
    Company.find(params[:id]).destroy
    redirect_to admin_companies_path, notice: "Компания была удалена"
  end

  private
  def correct_user
    redirect_to root_path unless current_user.super_admin?
  end
  def authenticate
    deny_access unless signed_in?
  end
end
