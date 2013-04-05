require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  def setup
    @user = create :user
    sign_in @user
    @params = {id: @user.id}
  end

  test "should get show" do
    get :show
    assert_response :success
  end

  test "should get new" do
    sign_out
    get :new
    assert_response :success
  end

  test "should post create" do
    sign_out
    @params[:user] = attributes_for(:super_user)
    post :create, @params
    assert_response :redirect
  end

  test "should get edit" do
    get :edit
    assert_response :success
  end

  test "should put update" do
    @params[:user] = attributes_for(:user)
    put :update, @params
    assert_response :success
  end

  test "should delete destroy" do
    delete :destroy
    assert_response :redirect
  end
end
