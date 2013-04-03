require 'test_helper'

class SessionControllerTest < ActionController::TestCase
  def setup
    @user = create :user
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should redirect new" do
    sign_in @user
    get :new
    assert_response :redirect
  end

  test "should post create" do
    get :create, {session: {login:@user.login, password: @user.password}}
    assert_response :redirect
  end

  test "should stop create" do
    get :create, {session: {login:"log", password:"123"}}
    assert_response :success
  end

  test "should get destroy" do
    get :destroy
    assert_response :redirect
  end
end
