require 'test_helper'

class Web::HelpsControllerTest < ActionController::TestCase
  def setup
    user = create :user
    sign_in user
    @help = create :help
    @params = {id: @help.id}
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get show" do
    get :show, @params
    assert_response :success
  end

end
