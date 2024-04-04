Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  concern :likable do
    member do
      post 'toggle_like'
    end
  end

  resources :blog_posts do
    resources :comments, only: %i[create]
  end

  resources :comments, only: %i[edit update destroy], concerns: :likable do
    resources :replies, concerns: :likable
  end

  # Defines the root path route ("/")
  root 'blog_posts#index', as: 'blog_posts_root'
end
