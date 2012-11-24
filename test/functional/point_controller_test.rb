require 'test_helper'

class PointControllerTest < ActionController::TestCase
  test "should get edit" do
    get :edit
    assert_response :success
  end

  test "should get show" do
    get :show
    assert_response :success
  end

  test "should get show_by_block" do
    get :show_by_block
    assert_response :success
  end

end
