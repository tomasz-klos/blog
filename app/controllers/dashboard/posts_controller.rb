module Dashboard
  class PostsController < ApplicationController
    layout('dashboard')

    def index
      @posts = current_user.posts.order(created_at: :desc)
    end
  end
end
