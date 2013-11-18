PressMe::Application.routes.draw do
  # User facing paths.
  scope admin: false do
    root to: proc { |env|
      PostsController.action(:index).call(env)
    }

    resources :archives, only: [:index, :show], controller: :posts
    scope controller: :posts, action: :show do
      constraints = proc do |request|
        Post.find_from_slug_path(request.params[:path])
      end

      get '*path', to: :show, constraints: constraints, as: :permalink
    end

    scope controller: :terms do
      constraints = proc do |request|
        Options.where { name == [:tag_base, :category_base] }.any? do |option|
          option.value == request.params[:taxonomy]
        end
      end

      get ':taxonomy/:id', to: :show, constraints: constraints
    end

    resources :tags,       only: :show, controller: :terms, taxonomy: :tag
    resources :categories, only: :show, controller: :terms, taxonomy: :category
    resources :searches,   only: :index
  end

  concern :deletable do
    get :delete, on: :member
  end

  concern :show_form do
    get :show, as: :edit, action: :edit, on: :member
  end

  constraints prefix: /admin/ do
    scope ':prefix', admin: true, except: [:show, :edit] do
      resources :sites,    concerns: [:show_form, :deletable]
      resources :blogs,    concerns: [:show_form, :deletable]
      resources :posts,    concerns: [:show_form, :deletable]
      resources :terms,    concerns: [:show_form, :deletable]
      resources :comments, concerns: [:show_form, :deletable], except: :create
      resources :users,    concerns: [:show_form, :deletable]
    end
  end

  #match ''
end
