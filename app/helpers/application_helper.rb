module ApplicationHelper
  def title_tag_for post
    content_tag(post_title_tag, post.title) if post.is_a? Post
  end
end
