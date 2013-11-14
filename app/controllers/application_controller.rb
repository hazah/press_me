class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.


  layout 'admin', only: :new

  protect_from_forgery with: :exception

  before_action :parse_params

  #authorize_actions_for Post

protected

  expose(:account) { current_account }

  expose :posts
  expose :post

  expose(:posts?) { posts.any? || post.persisted? }

  expose(:post_title_tag) { action_name == 'index' ? :h2 : :h1 }

  def authenticate(scope = :user)
    authentication.authenticate scope: scope
  end

  def parse_params

  end

private

  def current_account
    @current_account ||= begin
      current_developer || current_user || global_user
    end
  end

  def current_developer
    authenticate :developer
    authentication.user :developer
  end

  def current_user
    authenticate
    authentication.user
  end

  def global_user
    authenticate :global
    authentication.user :global
  end

  def authentication
    request.env['warden']
  end
end
