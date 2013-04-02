require 'test_helper'

class SessionControllerTest < ActionController::TestCase
  def setup
    @user = create :user
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should post create" do
    get :create, {session: {login:@user.login, password: @user.password}}
    assert_response :redirect
  end

  test "should get destroy" do
    get :destroy
    assert_response :redirect
  end
end
