require 'test_helper'

class UserInfosControllerTest < ActionController::TestCase
  def setup
    user = create :user
    sign_in user
    @user_info = create :user_info
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

  #test "should get new" do
  #  get :new
  #  assert_response :success
  #end
  #
  #test "should post create" do
  #  @params[:company] = attributes_for(:company)
  #  post :create, @params
  #  assert_response :redirect
  #end

  test "should get edit" do
    get :edit, @params
    assert_response :redirect
  end

  test "should put update" do
    @params[:user_info] = attributes_for(:user_info)
    put :update, @params
    assert_response :redirect
  end

  test "should get destroy" do
    delete :destroy, @params
    assert_response :redirect
  end

end
