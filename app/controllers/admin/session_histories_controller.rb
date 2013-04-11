#coding: utf-8
class Admin::SessionHistoriesController < Admin::ApplicationController

  def index
    @q = SessionHistory.sorted.ransack(params[:q])
    @session_histories = @q.result(distinct: true)
  end

  def destroy
    SessionHistory.find(params[:id]).destroy
    redirect_to admin_session_histories_path, :notice => "Запись удалена"
  end

end
