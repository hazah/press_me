require 'test_helper'

class PostAuthorizerTest < ActiveSupport::TestCase
  test "anonymous user can read published posts" do
    user = users(:one)
    assert user.can_read?(Post.published), 'anonymous user cannot read published posts.'
  end

  test "anonymous user cannot read unpublished posts" do
    user = users(:one)
    assert_not user.can_read?(Post.unpublished), 'anonymous user can read unpublished posts.'
  end
end
