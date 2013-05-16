require 'test_helper'

class Web::PublicStandardsControllerTest < ActionController::TestCase
  def setup
    user = create :user
    sign_in user
    super_user = create :super_user
    @standard = create :standard, user: super_user
    @params = { id: @standard.id }
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get show" do
    get :show, @params
    assert_response :success
  end

  test "should get take" do
    get :take, @params
    assert_response :redirect
  end

end
