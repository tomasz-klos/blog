class PostsController < ApplicationController
  def index
    @posts = Post.published.order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
    @comment = @post.comments.new
    @comments = @post.comments.order(created_at: :asc)
  end
end
