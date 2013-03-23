#coding: utf-8
class DraftsController < ApplicationController
  before_filter :authenticate
  before_filter :correct_user, only: [:show, :edit, :update, :destroy]
  # GET /dafts
  # GET /dafts.json
  def index
    @drafts = Draft.find_all_by_user_id(current_user.id)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @drafts }
    end
  end

  # GET /dafts/1
  # GET /dafts/1.json
  def show
    @draft = Draft.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @draft }
    end
  end

  # GET /dafts/new
  # GET /dafts/new.json
  def new
    @draft = Draft.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @draft }
    end
  end

  # GET /dafts/1/edit
  def edit
    @draft = Draft.find(params[:id])
  end

  # POST /dafts
  # POST /dafts.json
  def create
    @draft = Draft.new(params[:draft])
    @draft.user_id = current_user.id

    respond_to do |format|
      if @draft.save
        format.html { redirect_to @draft, flash: { success: 'Черновик был успешно создан' } }
        format.json { render json: @draft, status: :created, location: @draft }
      else
        format.html { render action: "new" }
        format.json { render json: @draft.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /dafts/1
  # PUT /dafts/1.json
  def update
    @draft = Draft.find(params[:id])

    respond_to do |format|
      if @draft.update_attributes(params[:draft])
        format.html { redirect_to @draft, flash: { success: 'Черновик был успешно обновлён'} }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @draft.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dafts/1
  # DELETE /dafts/1.json
  def destroy
    @draft = Draft.find(params[:id])
    @draft.destroy

    respond_to do |format|
      format.html { redirect_to drafts_url, notice: 'Черновик был успешно удалён' }
      format.json { head :no_content }
    end
  end

  def save
    draft = Draft.find(params[:id])

    new_standard = Standard.new(name: draft.name, content: draft.content, user_id: draft.user_id,
                                number: Standard.find_numbers(current_user).first)
    if new_standard.save
      draft.destroy
      redirect_to standard_path(new_standard.link), flash: { success: "Черновик успешно сохранен" }
    else
      redirect_to draft, error: "Что-то пошло не так"
    end
  end

  private
  def authenticate
    deny_access unless signed_in?
  end

  def correct_user
    draft = Draft.find(params[:id])
    redirect_to drafts_path unless current_user?(draft.user)
  end
end
