require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module PressMe
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    config.cache_store = :dalli_store

    config.middleware.insert_before ActionDispatch::Flash, Warden::Manager do |manager|
      manager.default_scope = :user

      manager.scope_defaults :user,       strategies: [:email_password]
      manager.scope_defaults :developer,  strategies: [:developer]
      manager.scope_defaults :global,     strategies: [:global]

      manager.failure_app = proc do |env|
        # TODO: Point this to a controller action
        [200, {}, 'Authentication Required']
      end
    end
  end

  # Authentication configuration.

  Warden::Strategies.add :email_password do
    def valid?
      params[:email] || params[:password]
    end

    def authenticate!
      if account = PressMe.account_class.find_by_email(params[:email])
        account.authenticate(params[:password]).tap do |a|
          a.nil? ? fail!("Authentication Failed") : success!(a)
        end
      end
    end
  end

  Warden::Strategies.add :global do
    def valid?
      true
    end

    def authenticate!
      PressMe.account_class.global.build.tap do |account|
      end
    end
  end

  Warden::Strategies.add :developer do
    def valid?
      Rails.development?
    end

    def authenticate!
      PressMe.account_class.developer.build.tap do |account|
      end
    end
  end

  Warden::Manager.serialize_into_session do |account|
    account.id
  end

  Warden::Manager.serialize_from_session do |id|
    PressMe.account_class.find id
  end

  class << self
    def account_class
      @account_class
    end

    def account_class=(klass)
      @account_class = klass
    end

    def anonymous
      0
    end

    def developer
      1
    end
  end
end
