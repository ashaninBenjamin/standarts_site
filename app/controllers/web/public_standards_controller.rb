#coding: utf-8
class Web::PublicStandardsController < Web::ApplicationController
  def index
    @users = User.exclude(current_user).decorate
  end

  def show
    @standard = Standard.find(params[:id])
  end

  def take
    @standard = Standard.find(params[:id])
    dup_of_standard = @standard.dup
    dup_of_standard.user_id = current_user.id
    dup_of_standard.number = current_user.standards.roots.first.available_number
    dup_of_standard.parent = current_user.standards.roots.first
    if dup_of_standard.save
      redirect_to public_standards_path
      flash_success
    else
      redirect_to public_standards_path
      flash_error
    end
  end
end
