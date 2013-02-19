#coding: utf-8
class CompanyController < ApplicationController
  before_filter :authenticate, :only => [:index, :edit, :update]
  before_filter :have_access, :only => [:index]
  before_filter :correct_user, :only => [:edit, :update]

  def index
    @all = Company.all
  end

  def new
    @new = Company.new
    @user_id = params[:user_id]
  end

  def create
    new = Company.new(params[:company])
    @new = new
    if new.save
      flash[:success] = "Успешно добавлена информация о компании. Регистрация прошла успешно!"
      user = User.find(params[:user_id])
      user.update_attribute(:company_id, new.id)
      sign_in user
      redirect_to standard_index_path
    else
      render "new"
    end
  end

  def edit
    @edit = Company.find(params[:id])
    @user = User.find_by_company_id(@edit)
  end

  def update
    upd = Company.find(params[:id])
    @edit = upd
    @user = User.find_by_company_id(@edit)
    if upd.update_attributes(params[:company])
      flash[:success] = "Обновление прошло успешно"
      redirect_to edit_company_path(upd)
    else
      render "edit"
    end
  end

  def show
    @company = Company.find(params[:id])
  end

  def destroy
  end

  private
  def authenticate
    deny_access unless signed_in?
  end

  def have_access
    redirect_to root_path unless current_user.super_admin?
  end

  def correct_user
    @user = User.find_by_company_id(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end
end
