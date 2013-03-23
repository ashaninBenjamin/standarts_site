#coding: utf-8
class SessionHistoriesController < ApplicationController
  before_filter :authenticate, :have_access

  def index
    @all = SessionHistory.scoped
  end

  def destroy
    SessionHistory.find(params[:id]).destroy
    redirect_to session_histories_path, :notice => "Запись удалена"
  end

  private
  def authenticate
    deny_access unless signed_in?
  end

  def have_access
    redirect_to root_path unless current_user.super_admin?
  end
end
