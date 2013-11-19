PressMe::Application.routes.draw do
  # User facing paths.
  defaults admin: false do
    # Could be any page
    root 'application#index'

    # Blog archive
    get 'archives/:year(/:month(/:day))' => 'posts#index', as: :archives
    resources :archives, only: [:index, :show], controller: :posts, as: :posts
    resources :searches, only: :index

    # Blog taxonomies
    resources :tags,       only: :show, controller: :terms, taxonomy: :tag
    resources :categories, only: :show, controller: :terms, taxonomy: :category
  end

  scope ':prefix', except: [:show, :edit] do
    constraints prefix: /admin/ do
      defaults admin: true do
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
          resources :comments, only: :create
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
