require 'test_helper'

class Admin::CompaniesControllerTest < ActionController::TestCase
  def setup
    @user = create :super_user
    @company = create :company
    sign_in @user
    @params = {id: @company.id}
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get show" do
    get :show, @params
    assert_response :success
  end

  test "should delete destroy" do
    delete :destroy, @params
    assert_response :redirect
    assert !Company.exists?(@company)
  end
end
