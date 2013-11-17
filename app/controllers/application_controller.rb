class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  layout 'admin', only: [:new, :edit, :delete]


  before_action do
    # TODO: parse params
  end

  before_action(only: :index) do
    authorize_action_for posts
  end

  before_action(exept: :index) do
    authorize_action_for post
  end

protected

  expose(:account) { current_account }

  expose :posts
  expose :post

  expose(:posts?) { posts.any? || post.persisted? }

  expose(:current_account) { current_developer || current_user || global_user }

  expose(:current_developer) do
    authenticate :developer
    authentication.user :developer
  end

  expose(:current_user) do
    authenticate
    authentication.user
  end

  expose(:global_user) do
    authenticate :global
    authentication.user :global
  end

  def authenticate(scope = :user)
    authentication.authenticate scope: scope
  end

  def authentication
    request.env['warden']
  end
end
