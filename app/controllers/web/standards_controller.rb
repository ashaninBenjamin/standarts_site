# coding: utf-8
class Web::StandardsController < Web::ApplicationController

  def index
    @q = current_user.standards.ransack(params[:q])
    @standards = Standard.sort_standards_by_code @q.result(distinct: true).decorate
  end

  def new
    @standard = Standard.new
    @select = Standard.sort_standards_by_code current_user.standards.decorate
    @arr = current_user.standards.root_numbers
  end

  def create
    @standard = current_user.standards.build(params[:standard])
    @select = Standard.sort_standards_by_code current_user.standards.decorate
    @arr = current_user.standards.root_numbers
    if @standard.save
      redirect_to standard_path(@standard.decorate.link)
      flash_success
    else
      render action: :new
    end
  end

  def edit
    @standard = current_user.standards.find_by_link(params[:id])
    @link = @standard.decorate.link
    @select = Standard.sort_standards_by_code current_user.standards.exclude(@standard.descendants << @standard).decorate
    @arr = ((@standard.parent ? @standard.parent.node_numbers : current_user.standards.root_numbers) << @standard.number).sort
  end

  def update
    @standard = current_user.standards.find_by_link(params[:id])
    @link = @standard.decorate.link
    @select = Standard.sort_standards_by_code current_user.standards.exclude(@standard.descendants << @standard).decorate
    @arr = ((@standard.parent ? @standard.parent.node_numbers : current_user.standards.root_numbers) << @standard.number).sort
    if @standard.update_attributes(params[:standard])
      redirect_to standard_path(@link)
      flash_success
    else
      render action: :edit
    end
  end

  def show
    @standard = current_user.standards.find_by_link(params[:id]).decorate
    @children = Standard.sort_standards_by_code @standard.children
  end

  def destroy
    standard = current_user.standards.find_by_link(params[:id])
    standard.destroy
    redirect_to standards_path
    flash_notice
  end

  def number_selection
    @arr = params[:value].blank? ? current_user.standards.root_numbers : Standard.find(params[:value]).node_numbers
    if (params[:native_id])
      if (params[:value].eql? Standard.find(params[:native_id]).parent_id.to_s)
        @arr << Standard.find(params[:native_id]).number
        @arr.sort!
      end
    end
    render partial: "web/standards/number_selection", locals: {obj: Standard.new}
  end

  def take_pattern
    old = current_user.standards
    old.destroy_all

    dict = Hash.new
    pattern = Standard.all_by_super_admin
    pattern.each do |one|
      new = one.dup
      new.user_id = current_user.id
      new.save
      dict[one.id] = new.id
    end

    own = current_user.standards
    own.each do |one|
      if one.parent
        one.update_attributes(parent_id: dict[one.parent_id])
      end
    end
    redirect_to standards_path, flash: {success: "Шаблон принят"}
  end

end