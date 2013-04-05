require 'test_helper'

class Admin::SessionHistoriesControllerTest < ActionController::TestCase
  def setup
    user = create :super_user
    sign_in user
    @session_history = create :session_history, user: user
    @params = {id: @session_history.id}
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should delete destroy" do
    delete :destroy, @params
    assert_response :redirect
  end
end
