require 'test_helper'

class StandardsControllerTest < ActionController::TestCase
  def setup
    user = create :user
    sign_in user
    @standard = create :standard, user: user
    @params = {id: @standard.link}
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
    post :create
    assert_response :success

    @params[:standard] = attributes_for(:standard)
    post :create, @params
    assert_response :redirect
  end

  test "should get edit" do
    get :edit, @params
    assert_response :success
  end

  test "should put update" do
    @params[:standard] = attributes_for(:standard)
    put :update, @params
    assert_response :redirect
    standard = Standard.find_by_link(@params[:id])
    assert standard
  end

  test "should delete destroy" do
    delete :destroy, @params
    assert_response :redirect
    assert !Standard.exists?(@standard)
  end

  test "should get number_secetion" do
    get :number_selection
    assert_response :success
  end

  test "should take_pattern" do
    get :take_pattern
    assert_response :redirect
  end
end
