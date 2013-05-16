require 'test_helper'

class Api::StandardsControllerTest < ActionController::TestCase
  def setup
    user = create :user
    @standard = create :standard, user: user
    @params = {id: @standard.id, format: :json}
  end

  test "should get numbers" do
    get :numbers, @params
    assert_response :success
  end
end