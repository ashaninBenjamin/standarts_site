#coding: utf-8
class UserInfoController < ApplicationController
  def index
    @all = UserInfo.all
  end

  def new
    @new = UserInfo.new
    @user_id = params[:user_id]
  end

  def create
    new = UserInfo.new(params[:new])
    if new.save
      flash[:success] = "Успешно добавлена информация о пользователе"
      if (!params[:user_id].blank?)
        user = User.find(params[:user_id])
        user.update_attribute(:user_info_id, new.id)
        redirect_to new_company_path(:user_id => user.id)
      else
        redirect_to new_company_path
      end
    else
      flash[:error] = "Ошибка"
      render "new"
    end
  end

  def edit
    @edit = UserInfo.find(params[:id])
    @user = User.find_by_user_info_id(@edit)
  end

  def update
    upd = UserInfo.find(params[:id])
    if upd.update_attributes(params[:edit])
      flash[:success] = "Обновление прошло успешно"
      redirect_to edit_user_info_path(upd)
    else
      flash[:error] = "Что-то пошло не так"
      render "edit"
    end
  end

  def show
    @user_info = UserInfo.find(params[:id])
  end

  def destroy

  end
end
