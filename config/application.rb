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

    config.cache_store = Dalli::Client.new("localhost:11211", value_max_bytes: 10485760)
    config.static_cache_control = "public, max-age=2592000"

    config.middleware.insert_after Rack::Cache, Dragonfly::Middleware, :file_upload
    config.middleware.insert_after Rack::Cache, Rack::Rewrite do

    end

    config.middleware.insert_after ActionDispatch::Flash, Warden::Manager do |manager|
      manager.default_scope = :user

      manager.scope_defaults :user,       strategies: [:email_password]
      manager.scope_defaults :developer,  strategies: [:developer]
      manager.scope_defaults :global,     strategies: [:global]

      manager.failure_app = proc do |env|
        request = ActionDispatch::Request.new(env)
        ApplicationController.action(:access_denied).call(env)
      end
    end
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
      @developer ||= 1
    end

    def developer=(id)
      @developer = id
    end
  end
end
