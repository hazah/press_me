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

  concern :show_form do
    member do
      get :edit, as: :show
    end
  end

  scope :admin do
    resources :sites, except: [:show, :edit], concerns: [:show_form]
    resources :blogs, except: [:show, :edit], concerns: [:show_form]
    resources :posts, except: [:show, :edit], concerns: [:show_form]
    resources :terms, except: [:show, :edit], concerns: [:show_form]
    resources :comments, except: [:show, :edit], concerns: [:show_form]
    resources :users, except: [:show, :edit], concerns: [:show_form]
  end

  #match ''
end
