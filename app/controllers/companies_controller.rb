#coding: utf-8
class CompaniesController < ApplicationController
  before_filter :authenticate, :only => [:edit, :update, :show]

  def new
    @company = Company.new
  end

  def create
    @company = current_user.build_company(params[:company])
    if @company.save
      current_user.save
      redirect_to standards_path, flash: {success: "Успешно добавлена информация о компании. Регистрация прошла успешно!"}
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
      redirect_to edit_user_company_path, flash: {success: "Обновление прошло успешно"}
    else
      render "edit"
    end
  end

  def show
    @company = current_user.company
  end

  private
  def authenticate
    deny_access unless signed_in?
  end
end
