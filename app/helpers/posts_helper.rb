module PostsHelper
  def post_title_tag
    action_name == 'index' ? :h2 : :h1
  end
end
