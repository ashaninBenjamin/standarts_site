#coding: utf-8
class Admin::SessionHistoriesController < Admin::ApplicationController

  def index
    @session_histories = SessionHistory.sorted
  end

  def destroy
    SessionHistory.find(params[:id]).destroy
    redirect_to admin_session_histories_path, :notice => "Запись удалена"
  end

end
