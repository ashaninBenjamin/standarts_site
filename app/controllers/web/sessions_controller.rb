# coding: utf-8
class Web::SessionsController < Web::ApplicationController
  skip_before_filter :authenticate!
  skip_before_filter :registration_passed!

  def new
    if signed_in? && current_user.correct?
      redirect_to standards_path
    end
    @type = UserSignInType.new
  end

  def create
    @type = UserSignInType.new(params[:user_sign_in_type])

    if @type.valid?
      user = @type.user
      sign_in user
      redirect_to standards_path
      flash_success
    else
      flash_error
      render action: :new
    end
  end

  def destroy
    sign_out
    redirect_to new_session_path
  end
end
