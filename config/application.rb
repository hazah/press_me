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

    initializer :app_init, before: :build_middleware_stack do
      config.middleware.insert 1, Dragonfly::Middleware, :file_upload

      routes.append do
        # User facing paths.
        defaults admin: false do
          # Could be any page
          controller :application do
            root to: :index
          end

          # Blog
          scope as: :page do
            resources :posts, only: [:index, :show]

            scope only: :show do
              resource :archive do
                scope path: '' do
                  resources :year do
                    resources :month do
                      resources :day
                    end
                  end
                end
              end
            end

            resources :tags,       only: :show, taxonomy: :tag,      controller: :terms
            resources :categories, only: :show, taxonomy: :category, controller: :terms

            resources :searches, only: [:index, :show]
          end
        end

        scope ':prefix', except: [:show, :edit] do
          # Administration
          constraints prefix: /admin/ do
            defaults admin: true, prefix: :admin do
              # Route to the delete form
              concern :deletable do |options|
                get :delete, options.merge(on: :member)
              end

              # Routes the edit_resource helpers have the show path instead of having the /edit suffix.
              concern :show_form do |options|
                get :show, options.merge(as: :edit, action: :edit, on: :member)
              end

              # Common elements to administered resources.
              concern :admin do |options|
                concerns [:show_form, :deletable], options
              end

              # Multi-site / Multi-blog support
        #      resources :sites,
        #      resources :blogs,

              # Core blog administration
              resources :posts, concerns: :admin do
                resources :comments, only: :create, path: ''
              end

              # All taxonomies are handled through the terms controller, but they are represented differently
              # Depending on their type.
              resources :tags,       concerns: :admin, controller: :terms, taxonomy: :tag
              resources :categories, concerns: :admin, controller: :terms, taxonomy: :category

              # Comments aren't ever created through an administered index page because they are added directly
              # to posts.
              resources :comments, concerns: :admin, except: [:show, :edit, :new, :create]
              resources :users,    concerns: :admin
            end
          end
        end
      end

      routes.clear!
      routes.finalize!

      url_helpers = routes.url_helpers

      config.middleware.insert 1, Rack::Rewrite do
        singleton_class.instance_eval do
          include url_helpers
        end
      end
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
