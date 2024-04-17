module Dashboard
  class PostsController < ApplicationController
    include ActionView::RecordIdentifier

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

      if @post.save(validate: false)
        render(json: { redirect_path: edit_dashboard_post_path(@post) }, status: :created)
      else
        render(:new, status: :unprocessable_entity)
      end
    end

    def edit; end

    def update
      @post.assign_attributes(post_params)

      if @post.draft? && @post.save(validate: false)
        render(turbo_stream: turbo_stream.update(dom_id(@post, :content),
                                                 partial: 'partials/post_content',
                                                 locals: { post: @post }))

      elsif @post.published? && @post.save
        render(turbo_stream: [
                 turbo_stream.update(dom_id(@post, :content), partial: 'partials/post_content', locals: { post: @post }),
                 turbo_stream.update(dom_id(@post, :form), partial: 'dashboard/posts/form', locals: { post: @post })
               ])

      else
        render(:edit, status: :unprocessable_entity)
      end
    end

    def destroy
      if @post.destroy
        redirect_to(dashboard_posts_path, notice: 'Post was successfully deleted.')
      else
        redirect_to(@post)
      end
    end

    def publish
      redirect_path = request.referrer || dashboard_posts_path

      @post.publish!

      if @post.published?
        redirect_to(redirect_path, notice: 'Post was successfully published.')
      else
        error = @post.errors.full_messages.first
        redirect_to(redirect_path, alert: "Post could not be published, because: #{error}")
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
      redirect_to(posts_root_path)
    end

    def authorize_user!
      return if @post.user == current_user

      redirect_to(posts_root_path, alert: 'You are not authorized to edit this post.')
    end
  end
end
