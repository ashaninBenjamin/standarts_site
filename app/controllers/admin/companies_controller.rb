#coding: utf-8
class Admin::CompaniesController < Admin::ApplicationController
  # GET /admin/companies
  # GET /admin/companies.json
  def index
    @q = Company.ransack(params[:q])
    @companies = CompanyDecorator.decorate_collection @q.result

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @companies }
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
    company = Company.find(params[:id])
    company.destroy
    redirect_to admin_companies_path
    flash_notice
  end

end
