#coding: utf-8
class Web::CompaniesController < Web::ApplicationController
  skip_before_filter :authenticate!, only: [:new, :create]
  skip_before_filter :registration_passed!, only: [:new, :create]

  def new
    @company = Company.new
  end

  def create
    @company = current_user.build_company(params[:company])
    if @company.save
      current_user.save
      redirect_to standards_path
      flash_success
    else
      render "new"
    end
  end

  def edit
    @company = current_user.company
  end

  def update
    @company = current_user.company
    if @company.update_attributes(params[:company])
      redirect_to edit_user_company_path
      flash_success
    else
      render "edit"
    end
  end

  def show
    @company = current_user.company
  end

end