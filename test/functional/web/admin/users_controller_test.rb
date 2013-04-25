require 'test_helper'

class Web::Admin::UsersControllerTest < ActionController::TestCase
  def setup
    @user = create :super_user
    sign_in @user
    @params = {id: @user.id}
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
    assert !User.exists?(@user)
  end
end
