Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :blog_posts do
    resources :comments, only: %i[create]
  end

  resources :comments, only: %i[edit update destroy] do
    member do
      post 'toggle_like'
    end
    resources :replies do
      member do
        post 'toggle_like'
      end
    end
  end

  # Defines the root path route ("/")
  root 'blog_posts#index', as: 'blog_posts_root'
end
