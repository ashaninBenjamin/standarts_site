require 'test_helper'

class CompaniesControllerTest < ActionController::TestCase
  def setup
    @user = create :user
    sign_in @user
    @company = create :company
    @params = {id: @company.id, user_id: @user}
  end

  test "should get index" do
    get :index, user: :user
    assert_response :success
  end

  test "should get show" do
    get :show, @params
    assert_response :success
  end

  test "should get new" do
    get :new, user_id: @user
    assert_response :success
  end

  test "should post create" do
    @params[:company] = attributes_for(:company)
    post :create, @params
    assert_response :redirect
  end

  test "should get edit" do
    get :edit, @params
    assert_response :redirect
  end

  test "should put update" do
    @params[:company] = attributes_for(:company)
    put :update, @params
    assert_response :redirect
  end

end
