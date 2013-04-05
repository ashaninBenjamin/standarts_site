require 'test_helper'

class UserInfosControllerTest < ActionController::TestCase
  def setup
    @user = create :user
    @user_info = create :user_info
    sign_in @user
    @params = {id: @user_info.id}
  end

  test "should get show" do
    get :show
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should post create" do
    @params[:user_info] = attributes_for(:user_info)
    set_temp_user @user
    post :create, @params
    assert_response :redirect
  end

  test "should get edit" do
    get :edit
    assert_response :success
  end

  test "should put update" do
    @params[:user_info] = attributes_for(:user_info)
    put :update, @params
    assert_response :redirect
  end

end
