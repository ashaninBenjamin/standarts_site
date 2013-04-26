#coding: utf-8
class Web::Admin::CompaniesController < Web::Admin::ApplicationController

  def index
    @q = Company.ransack(params[:q])
    @companies = CompanyDecorator.decorate_collection @q.result
  end

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
