require 'test_helper'

class Api::NewsControllerTest < ActionController::TestCase
  def setup
    @news = create :news
    @params = { id: @news.id, format: :json }
  end

  test "should get index" do
    get :index, {format: :json}
    assert_response :success
  end

  test "should get show" do
    get :show, @params
    assert_response :success
  end
end