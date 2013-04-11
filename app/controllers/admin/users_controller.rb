#coding: utf-8
class Admin::UsersController < Admin::ApplicationController

  # GET /admin/users
  # GET /admin/users.json
  def index
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /admin/users/1
  # GET /admin/users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # DELETE /admin/users/1
  # DELETE /admin/users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to admin_users_url }
      format.json { head :no_content }
    end
  end

end
