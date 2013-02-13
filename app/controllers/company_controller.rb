#coding: utf-8
class CompanyController < ApplicationController
  def index
    @all = Company.all
  end

  def new
    @new = Company.new
    @user_id = params[:user_id]
  end

  def create
    new = Company.new(params[:new])
    if new.save
      flash[:success] = "Успешно добавлена информация о компании. Регистрация прошла успешно!"
      user = User.find(params[:user_id])
      user.update_attribute(:company_id, new.id)
      sign_in user
      redirect_to standard_index_path
    else
      flash[:error] = "Ошибка"
      render "new"
    end
  end

  def edit
    @edit = Company.find(params[:id])
    @user = User.find_by_company_id(@edit)
  end

  def update
    upd = Company.find(params[:id])
    if upd.update_attributes(params[:edit])
      flash[:success] = "Обновление прошло успешно"
      redirect_to edit_company_path(upd)
    else
      flash[:error] = "Что-то пошло не так"
      render "edit"
    end
  end

  def show
    @company = Company.find(params[:id])
  end

  def destroy
  end
end
