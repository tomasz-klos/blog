class PostsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_post, only: %i[show edit update destroy]
  before_action :authorize_user!, only: %i[edit update destroy]

  def index
    @posts = Post.all
  end

  def show
    @comment = @post.comments.new
    @comments = @post.comments.order(created_at: :asc)
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to @post
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: 'Blog post was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @post.destroy
      redirect_to posts_root_path, notice: 'Blog post was successfully destroyed.'
    else
      redirect_to @post
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end

  def set_post
    @post = Post.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end

  def authorize_user!
    return if @post.user == current_user

    redirect_to posts_root_path, alert: 'You are not authorized to edit this post.'
  end
end
