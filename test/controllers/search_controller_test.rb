require 'test_helper'

class SearchControllerTest < ActionController::TestCase
  test "anonymous should get index" do
    warden.set_user(users(:anonymous))
    get :index, admin: false
    assert_response :success
  end
end
