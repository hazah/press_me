require 'test_helper'

class SearchesControllerTest < ActionController::TestCase
  test "anonymous should get index" do
    warden.set_user(users(:anonymous))
    get :index
    assert_response :success
  end
end
