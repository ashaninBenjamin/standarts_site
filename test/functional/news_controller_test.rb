require 'test_helper'

class NewsControllerTest < ActionController::TestCase
  def setup
    user = create :user
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
end
