module Dashboard
  class PostsController < ApplicationController
    layout('dashboard')

    before_action(:set_post, only: %i[edit update destroy publish unpublish])
    before_action(:authorize_user!, only: %i[edit update destroy])

    def index
      @posts = current_user.posts.order(created_at: :desc)
    end

    def new
      @post = current_user.posts.new
    end

    def create
      @post = current_user.posts.new(post_params)
      if @post.save
        redirect_to(edit_dashboard_post_path(@post), notice: 'Draft post was successfully created.')
      else
        render(:new, status: :unprocessable_entity)
      end
    end

    def edit; end

    def update
      return if @post.update(post_params)

      render(:edit, status: :unprocessable_entity)
    end

    def destroy
      if @post.destroy
        redirect_to(dashboard_posts_path, notice: 'Post was successfully deleted.')
      else
        puts "ERROR: #{@post.errors.full_messages}"
        redirect_to(@post)
      end
    end

    def publish
      @post.publish!

      if @post.published?
        redirect_to(dashboard_posts_path, notice: 'Post was successfully published.')
      else
        redirect_to(dashboard_posts_path, alert: 'Post could not be published.')
      end
    end

    def unpublish
      @post.unpublish!

      if @post.draft?
        redirect_to(dashboard_posts_path, notice: 'Post was successfully unpublished.')
      else
        redirect_to(dashboard_posts_path, alert: 'Post could not be unpublished.')
      end
    end

    private

    def post_params
      params.require(:post).permit(:title, :content)
    end

    def set_post
      @post = Post.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to(root_path)
    end

    def authorize_user!
      return if @post.user == current_user

      redirect_to(posts_root_path, alert: 'You are not authorized to edit this post.')
    end
  end
end
