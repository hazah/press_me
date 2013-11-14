require 'test_helper'

class SearchesControllerTest < ActionController::TestCase
  test "should get index" do
    warden.set_user(User::Anonymous.new)
    get :index
    assert_response :success
  end
end
