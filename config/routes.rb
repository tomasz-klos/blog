Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  concern :likable do
    member do
      post 'toggle_like'
    end
  end

  resources :posts do
    resources :comments, only: %i[create]
  end

  resources :comments, only: %i[edit update destroy], concerns: :likable do
    resources :replies, concerns: :likable
  end

  namespace :dashboard do
    resources :posts, only: %i[index]

    root to: 'pages#dashboard'
  end

  # Defines the root path route ("/")
  root 'posts#index', as: 'posts_root'
end
