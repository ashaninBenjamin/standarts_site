# coding: utf-8
class StandardController < ApplicationController
  before_filter :authenticate

  def index
    @all = Standard.find_all_with_user(current_user)
  end

  def new
    @new = Standard.new
    @select = Standard.sort_it(Standard.find_all_by_user_id(current_user.id))
    @arr = Standard.find_numbers(current_user)
  end

  def create
    new = Standard.new(params[:standard])
    @new = new
    @select = Standard.sort_it(Standard.find_all_by_user_id(current_user.id))
    @arr = Standard.find_numbers(current_user)
    new.number = params[:number]
    new.user_id = current_user.id
    if new.save
      flash[:success] = "Успешно добавлен раздел"
      redirect_to standard_path(new.link)
    else
      render "new"
    end
  end

  def edit
    @edit = Standard.find_by_link(params[:id], current_user)
    @select = Standard.sort_it(Standard.find_all_by_user_id(current_user.id))
    @arr = (Standard.find_numbers(@edit.has_parent? ? @edit.parent_id : current_user) << @edit.number).sort
  end

  def update
    upd = Standard.find_by_link(params[:id], current_user)
    @edit = upd
    @select = Standard.sort_it(Standard.find_all_by_user_id(current_user.id))
    @arr = (Standard.find_numbers(@edit.has_parent? ? @edit.parent_id : current_user) << @edit.number).sort
    if upd.update_attributes(params[:standard])
      flash[:success] = "Раздел успешно обновлён"
      redirect_to standard_path(upd.link)
    else
      render "edit"
    end
  end

  def show
    @it = Standard.find_by_link(params[:id], current_user)
    @children = @it.children if @it.has_children?
    if (@children)
      @children = Standard.sort_it(@children)
    end
  end

  def destroy
    Standard.find_by_link(params[:id], current_user).destroy
    flash[:notice] = "Раздел успешно удалён"
    redirect_to standard_index_path
  end

  def number_selection
    @arr = params[:value].blank? ? Standard.find_numbers(current_user) : Standard.find_numbers(params[:value])
    if (!params[:native_id].blank?)
      if (params[:value].to_i.eql?(Standard.find(params[:native_id]).parent_id))
        @arr = (@arr << Standard.find(params[:native_id]).number).sort
      end
    end
    render :partial => "standard/number_selection"
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
    flash[:success] = "Шаблон принят"
    redirect_to standard_index_path
  end

  private
  def authenticate
    deny_access unless signed_in?
  end
end