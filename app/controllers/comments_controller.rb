class CommentsController < ApplicationController
  before_action :authenticate_user!, only: %i[create edit update destroy]
  before_action :set_blog_post, only: %i[create edit update destroy]
  before_action :authorize_user!, only: %i[edit update destroy]

  def create
    @comment = @blog_post.comments.build(comment_params)
    @comment.user_id = current_user.id

    respond_to do |format|
      if @comment.save
        format.turbo_stream do
          turbo_stream.prepend('comments', partial: 'comments/comment', locals: { comment: @comment })
        end
      else
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(@comment, partial: 'comments/form', locals: { comment: @comment })
        end
      end
    end
  end

  def edit
    @comment = @blog_post.comments.find(params[:id])

    render turbo_stream: turbo_stream.replace(@comment, partial: 'comments/form', locals: { comment: @comment })
  end

  def update
    @comment = @blog_post.comments.find(params[:id])

    if @comment.update(comment_params)
      redirect_to @blog_post
    else
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(@comment, partial: 'comments/form', locals: { comment: @comment })
        end
      end
    end
  end

  def destroy
    @comment = @blog_post.comments.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.turbo_stream do
        turbo_stream.remove(@comment)
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_blog_post
    @blog_post = BlogPost.find(params[:blog_post_id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end

  def authorize_user!
    @comment = @blog_post.comments.find(params[:id])
    return if @comment.user == current_user

    redirect_to @blog_post
  end
end
