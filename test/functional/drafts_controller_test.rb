require 'test_helper'

class DraftsControllerTest < ActionController::TestCase
  def setup
    user = create :user
    sign_in user
    @draft = create :draft, user: user
    @params = {id: @draft.id}
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
    @params[:draft] = attributes_for(:draft)
    post :create, @params
    assert_response :redirect

  end

  test "should get edit" do
    get :edit, @params
    assert_response :success
  end

  test "should put update" do
    @params[:draft] = attributes_for(:draft)
    put :update, @params
    assert_response :redirect
  end

  test "should delete destroy" do
    delete :destroy, @params
    assert_response :redirect
  end

  test "should get save" do
    get :save, @params
    assert_response :redirect
  end
end
