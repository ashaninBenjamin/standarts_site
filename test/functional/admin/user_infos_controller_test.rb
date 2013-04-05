require 'test_helper'

class Admin::UserInfosControllerTest < ActionController::TestCase
  def setup
    @user = create :super_user
    @user_info = @user.user_info
    sign_in @user
    @params = {id: @user_info.id}
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get show" do
    get :show, @params
    assert_response :success
  end

  test "should delete destroy" do
    delete :destroy, @params
    assert_response :redirect
  end
end
