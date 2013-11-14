PressMe::Application.routes.draw do
  concern :deletable do
    get :delete
  end

  resources :posts, only: [:index, :show] do
    resources :comments, except: :index, shallow: true
  end

  resources :terms, only: :show
  resources :categories, only: :show, controller: :terms
  resources :searches, only: :index
  resources :archives, only: :index

  root to: proc { |env|
    PostsController.action(:index).call(env)
  }

  scope :admin do
    resources :sites, except: :show
    resources :blogs, except: :show
    resources :posts, except: :show
    resources :terms, except: :show
    resources :comments, except: :show
    resources :users, except: :show
  end
end
