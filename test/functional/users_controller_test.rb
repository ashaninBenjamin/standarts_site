require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  def setup
    @user = create :user
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

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should post create" do
    @params[:user] = attributes_for(:user)
    post :create, @params
    assert_response :success
  end

  test "should get edit" do
    get :edit, @params
    assert_response :success
  end

  test "should put update" do
    @params[:user] = attributes_for(:user)
    put :update, @params
    assert_response :redirect
  end

  test "should delete destroy" do
    delete :destroy, @params
    assert_response :redirect
  end
end
