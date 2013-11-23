class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  layout 'admin', only: [:new, :edit, :delete]

protected
  before_action do
    # TODO: parse params
  end

  expose(:account) { current_developer || current_user || global_user }

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

  expose :posts
  expose :post, exept: :index

  def authenticate(scope = :user)
    authenticator.authenticate scope: scope
  end

  def authenticator
    request.env['warden']
  end
end
