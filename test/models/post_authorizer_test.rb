require 'test_helper'

class PostAuthorizerTest < ActiveSupport::TestCase
  test "authorizers should be different for different scopes" do
    assert_not_equal Post.published.authorizer, Post.authorizer
    assert_not_equal Post.unpublished.authorizer, Post.all.authorizer
  end

  test "anonymous user can read published posts" do
    assert users(:anonymous).can_read?(Post.published), 'anonymous user cannot read published posts.'
  end

  test "anonymous user cannot read all posts" do
    assert_not users(:anonymous).can_read?(Post), 'anonymous user can read all posts.'
  end

  test "anonymous user cannot read unpublished posts" do
    assert_not users(:anonymous).can_read?(Post.unpublished), 'anonymous user can read unpublished posts.'
  end

  test "developer can read all posts" do
    assert users(:developer).can_read?(Post.all)
  end

  test "logged in user can read published posts" do
    assert users(:one).can_read?(Post.published), 'logged in user cannot read published posts.'
  end

  test "logged in user can read own posts" do
    assert users(:one).can_read?(Post.owned_by(users(:one))), 'logged in user cannot read own posts.'
  end

  test "logged in user can read own unpublished posts" do
    assert users(:one).can_read?(Post.unpublished.owned_by(users(:one))), 'logged in user cannot read own unpublished posts.'
  end

  test "logged in user cannot read other users' unpublished posts" do
    assert_not users(:one).can_read?(Post.unpublished.owned_by(users(:two))), "logged in user can read other users' unpublished posts."
  end
end
