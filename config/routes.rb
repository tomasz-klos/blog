Rails.application.routes.draw do
  devise_for :users, expect: [:edit, :update], controllers: {
    registrations: 'registrations'
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  concern :likable do
    member do
      post 'toggle_like'
    end
  end

  resources :posts, only: [:index, :show] do
    resources :comments, only: [:create]
  end

  resources :comments, only: [:edit, :update, :destroy], concerns: :likable do
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

  namespace :settings do
    root to: redirect('/settings/profile')
    resource :profile, only: [:show, :update]
    resource :account, only: [:show, :destroy]
    resource :security, only: [:show, :update]
  end

  root 'posts#index', as: 'posts_root'
end
