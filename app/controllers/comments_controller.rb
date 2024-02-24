class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  
  def create
  @blog_post = BlogPost.find(params[:blog_post_id])
  @comment = @blog_post.comments.build(comment_params)
  @comment.user_id = current_user.id
  
    respond_to do |format|
      if @comment.save
        format.turbo_stream { render turbo_stream: turbo_stream.prepend('comments', partial: 'comments/comment', locals: { comment: @comment }) }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace('comment-form', partial: 'comments/form', locals: { comment: @comment }) }
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end