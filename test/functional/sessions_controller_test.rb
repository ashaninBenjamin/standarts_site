require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  def setup
    @user = create :user
    @params = {}
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
    @params[:user] = attributes_for(:user)
    get :create, @params
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
