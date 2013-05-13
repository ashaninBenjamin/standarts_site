# coding: utf-8
class Web::StandardsController < Web::ApplicationController

  def index
    @q = current_user.standards.stem.ransack(params[:q])
    @standards = Standard.sort_standards_by_code @q.result(distinct: true).decorate
  end

  def new
    @standard = StandardNewType.new
    @available_numbers = @standard.available_numbers(current_user)
    @available_parents = Standard.sort_standards_by_code @standard.available_parents(current_user).decorate
  end

  def create
    @standard = current_user.standards.build(params[:standard])
    @standard = @standard.becomes(StandardNewType)
    @available_numbers = @standard.available_numbers(current_user)
    @available_parents = Standard.sort_standards_by_code @standard.available_parents(current_user).decorate
    if @standard.save
      redirect_to standard_path(@standard.link)
      flash_success
    else
      render action: :new
    end
  end

  def edit
    @standard = current_user.standards.find_by_link(params[:id])
    @standard = @standard.becomes(StandardEditType)
    @available_numbers = @standard.available_numbers
    @available_parents = Standard.sort_standards_by_code @standard.available_parents(current_user).decorate
  end

  def update
    @standard = current_user.standards.find_by_link(params[:id])
    @standard = @standard.becomes(StandardEditType)
    @available_numbers = @standard.available_numbers
    @available_parents = Standard.sort_standards_by_code @standard.available_parents(current_user).decorate
    if @standard.update_attributes(params[:standard])
      redirect_to standard_path(@standard.link)
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