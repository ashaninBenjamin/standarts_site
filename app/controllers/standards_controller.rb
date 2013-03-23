# coding: utf-8
class StandardsController < ApplicationController
  before_filter :authenticate

  def index
    @all = Standard.find_all_with_user(current_user)
  end

  def new
    @standard = Standard.new
    @select = Standard.find_all_with_user(current_user.id)
    @arr = Standard.find_numbers(current_user)
  end

  def create
    @standard = Standard.new(params[:standard])
    @select = Standard.find_all_with_user(current_user.id)
    @arr = Standard.find_numbers(current_user)
    @standard.user = current_user
    if @standard.save
      redirect_to standard_path(@standard.link), flash: { success: "Успешно добавлен раздел" }
    else
      render "new"
    end
  end

  def edit
    @standard = Standard.find_by_link(params[:id], current_user)
    @select = Standard.find_all_with_user(current_user.id)
    @select.delete(@standard)
    @arr = (Standard.find_numbers(@standard.has_parent? ? @standard.parent_id : current_user) << @standard.number).sort
  end

  def update
    @standard = Standard.find_by_link(params[:id], current_user)
    @select = Standard.find_all_with_user(current_user.id)
    @select.delete(@standard)
    @arr = (Standard.find_numbers(@standard.has_parent? ? @standard.parent_id : current_user) << @standard.number).sort
    if @standard.update_attributes(params[:standard])
      redirect_to standard_path(@standard.link), flash: { success: "Раздел успешно обновлён" }
    else
      render "edit"
    end
  end

  def show
    @it = Standard.find_by_link(params[:id], current_user)
    @children = @it.children if @it.has_children?
    if @children
      @children = Standard.sort_it(@children)
    end
  end

  def destroy
    Standard.find_by_link(params[:id], current_user).destroy
    redirect_to standards_path, notice: "Раздел успешно удалён"
  end

  def number_selection
    @arr = params[:value].blank? ? Standard.find_numbers(current_user) : Standard.find_numbers(params[:value])
    if (!params[:native_id].blank?)
      if (params[:value].to_i.eql?(Standard.find(params[:native_id]).parent_id))
        @arr = (@arr << Standard.find(params[:native_id]).number).sort
      end
    end
    render :partial => "standards/number_selection", :locals => {:obj => Standard.new }
  end

  def take_pattern
    #удаление всего до этого
    to_delete = Standard.find_all_by_user_id(current_user)
    to_delete.each { |one| one.destroy }
    #запись нового
    dict = Hash.new
    pattern = Standard.find_all_by_super_admin
    pattern.each do |one|
      new = one.dup
      new.user_id = current_user.id
      new.save
      dict[one.id] = new.id
    end
    #сопоставление всех родительских айдишек
    own = Standard.find_all_by_user_id(current_user)
    own.each do |one|
      if (!one.parent_id.blank?)
        one.update_attribute(:parent_id, dict[one.parent_id])
      end
    end
    redirect_to standards_path, flash: { success: "Шаблон принят" }
  end

  def pdf
    arr = params[:id].split('-')
    @all = Standard.where(user_id: current_user.id, id: arr)
    respond_to do |format|
      format.html {redirect_to standards_path }
      format.pdf
    end
  end

  private
  def authenticate
    deny_access unless signed_in?
  end
end