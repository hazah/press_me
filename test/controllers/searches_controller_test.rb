require 'test_helper'

class SearchesControllerTest < ActionController::TestCase
  test "should get index" do
    login_as(User::Anonymous.new)
    get :index
    assert_response :success
  end

end
