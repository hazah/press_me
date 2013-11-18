module Publishing
  extend ActiveSupport::Concern

protected
  def posts
    super.published
  end
end
