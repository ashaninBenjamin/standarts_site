# coding: utf-8
class StandardsController < ApplicationController
  before_filter :authenticate

  def index
    @all = Standard.sort_it current_user.standards
  end

  def new
    @standard = Standard.new
    @select = Standard.sort_it current_user.standards
    @arr = Standard.find_numbers(current_user)
  end

  def create
    @standard = current_user.standards.build(params[:standard])
    @select = Standard.sort_it current_user.standards
    @arr = Standard.find_numbers(current_user)
    if @standard.save
      redirect_to standard_path(@standard.link), flash: { success: "Успешно добавлен раздел" }
    else
      render "new"
    end
  end

  def edit
    @standard = current_user.standards.find_by_link(params[:id])
    @select = Standard.sort_it current_user.standards
    @select.delete(@standard)
    @arr = (Standard.find_numbers(@standard.parent ? @standard.parent_id : current_user) << @standard.number).sort
  end

  def update
    @standard = current_user.standards.find_by_link(params[:id])
    @select = Standard.sort_it current_user.standards
    @select.delete(@standard)
    @arr = (Standard.find_numbers(@standard.parent ? @standard.parent_id : current_user) << @standard.number).sort
    if @standard.update_attributes(params[:standard])
      redirect_to standard_path(@standard.link), flash: { success: "Раздел успешно обновлён" }
    else
      render "edit"
    end
  end

  def show
    @standard = current_user.standards.find_by_link(params[:id])
    @children = Standard.sort_it @standard.children
  end

  def destroy
    current_user.standards.find_by_link(params[:id]).destroy
    redirect_to standards_path, notice: "Раздел успешно удалён"
  end

  def number_selection
    @arr = params[:value].blank? ? Standard.find_numbers(current_user) : Standard.find_numbers(params[:value])
    if (params[:native_id])
      if (params[:value].to_i.eql?(Standard.find(params[:native_id]).parent_id))
        @arr = (@arr << Standard.find(params[:native_id]).number).sort
      end
    end
    render :partial => "standards/number_selection", :locals => {:obj => Standard.new }
  end

  def take_pattern
    #удаление всего до этого
    to_delete = current_user.standards
    to_delete.each { |one| one.destroy }
    #запись нового
    dict = Hash.new
    pattern = Standard.all_by_super_admin
    pattern.each do |one|
      new = one.dup
      new.user_id = current_user.id
      new.save
      dict[one.id] = new.id
    end
    #сопоставление всех родительских айдишек
    own = current_user.standards
    own.each do |one|
      if one.parent_id
        one.update_attribute(:parent_id, dict[one.parent_id])
      end
    end
    redirect_to standards_path, flash: { success: "Шаблон принят" }
  end

  private
  def authenticate
    deny_access unless signed_in?
  end
end