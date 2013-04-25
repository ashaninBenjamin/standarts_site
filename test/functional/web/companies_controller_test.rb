require 'test_helper'

class Web::CompaniesControllerTest < ActionController::TestCase
  def setup
    @user = create :user
    sign_in @user
    @company = @user.company
    @params = {id: @company.id}
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
    @params[:company] = attributes_for(:company)
    post :create, @params
    assert_response :redirect
  end

  test "should get edit" do
    get :edit
    assert_response :success
  end

  test "should put update" do
    @params[:company] = attributes_for(:company)
    put :update, @params
    assert_response :redirect
    company = Company.find(@params[:id])
    assert company
  end

end
