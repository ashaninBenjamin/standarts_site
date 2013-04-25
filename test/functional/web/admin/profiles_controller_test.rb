require 'test_helper'

class Web::Admin::ProfilesControllerTest < ActionController::TestCase
  def setup
    @user = create :super_user
    @profile = @user.profile
    sign_in @user
    @params = {id: @profile.id}
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
    assert !Profile.exists?(@profile)
  end
end
