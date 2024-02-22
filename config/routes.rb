Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get 'blog_posts/new', to: 'blog_posts#new', as: 'new_blog_post'
  get 'blog_posts/:id', to: 'blog_posts#show', as: 'blog_post'
  patch 'blog_posts/:id', to: 'blog_posts#update'
  get 'blog_posts/:id/edit', to: 'blog_posts#edit', as: 'edit_blog_post'
  delete 'blog_posts/:id', to: 'blog_posts#destroy'
  get 'blog_posts/:id/delete', to: 'blog_posts#delete', as: 'delete_blog_post'
  post 'blog_posts', to: 'blog_posts#create', as: 'blog_posts'

  # Defines the root path route ("/")
  root 'blog_posts#index', as: 'blog_posts_root'
end
