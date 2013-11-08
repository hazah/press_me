class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :parse_params

  expose :account { current_account }

  expose :posts
  expose :post

protected

  def authenticate(scope = :user)
    authentication.authenticate scope: scope
  end

private

  def parse_params

  end

  def current_account
    current_developer || current_user || global_user
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
    env['warden']
  end
end
