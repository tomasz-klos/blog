Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :blog_posts do
    resources :comments, only: %i[create edit update destroy] do
      resources :replies, only: %i[new create edit update destroy]
    end
  end

  # Defines the root path route ("/")
  root 'blog_posts#index', as: 'blog_posts_root'
end
