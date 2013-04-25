#coding: utf-8
class Web::Admin::SessionHistoriesController < Web::Admin::ApplicationController

  def index
    @q = SessionHistory.by_updated_at.ransack(params[:q])
    @session_histories = @q.result(distinct: true)
  end

  def destroy
    session_history = SessionHistory.find(params[:id])
    session_history.destroy
    redirect_to admin_session_histories_path
    flash_notice
  end

end
