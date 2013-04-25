require 'test_helper'

class Web::Admin::NewsControllerTest < ActionController::TestCase
  def setup
    user = create :super_user
    sign_in user
    @news = create :news
    @params = {id: @news.id}
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
    @params[:news] = attributes_for(:news)
    post :create, @params
    assert_response :redirect
  end

  test "should get edit" do
    get :edit, @params
    assert_response :success
  end

  test "should put update" do
    @params[:news] = attributes_for(:news)
    put :update, @params
    assert_response :redirect
    news = News.find(@params[:id])
    assert news
  end

  test "should get destroy" do
    delete :destroy, @params
    assert_response :redirect
    assert !News.exists?(@news)
  end
end
