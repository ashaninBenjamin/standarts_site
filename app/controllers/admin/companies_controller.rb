#coding: utf-8
class Admin::CompaniesController < Admin::ApplicationController
  # GET /admin/companies
  # GET /admin/companies.json
  def index
    @q = Company.ransack(params[:q])
    @companies = CompanyDecorator.decorate_collection @q.result
  end

  # GET /admin/companies/1
  # GET /admin/companies/1.json
  def show
    @company = Company.find(params[:id])
  end

  def destroy
    company = Company.find(params[:id])
    company.destroy
    redirect_to admin_companies_path
    flash_notice
  end

end
