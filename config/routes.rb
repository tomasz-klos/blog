Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  concern :likable do
    member do
      post 'toggle_like'
    end
  end

  resources :posts, only: %i[index show] do
    resources :comments, only: %i[create]
  end

  resources :comments, only: %i[edit update destroy], concerns: :likable do
    resources :replies, concerns: :likable
  end

  namespace :dashboard do
    root to: redirect('/dashboard/posts')
    resources :posts do
      member do
        post 'publish'
        post 'unpublish'
      end
    end
  end

  # Defines the root path route ("/")
  root 'posts#index', as: 'posts_root'
end
