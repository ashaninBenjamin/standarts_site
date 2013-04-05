#coding: utf-8
class CompaniesController < ApplicationController
  before_filter :authenticate, :only => [:edit, :update]

  def new
    @company = Company.new
  end

  def create
    @company = Company.new(params[:company])
    user = get_temp_user
    if @company.save
      user.update_attribute(:company_id, @company.id)
      sign_in user
      clear_temp_user
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

  def destroy
  end

  private
  def authenticate
    deny_access unless signed_in?
  end
end
