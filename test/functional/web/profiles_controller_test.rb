require 'test_helper'

class Web::ProfilesControllerTest < ActionController::TestCase
  def setup
    @user = create :user
    @profile = create :profile
    sign_in @user
    @params = {id: @profile.id}
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
    @params[:profile] = attributes_for(:profile)
    post :create, @params
    assert_response :redirect
  end

  test "should get edit" do
    get :edit
    assert_response :success
  end

  test "should put update" do
    @params[:profile] = attributes_for(:profile)
    put :update, @params
    assert_response :redirect
    profile = Profile.find(@params[:id])
    assert profile
  end

end
