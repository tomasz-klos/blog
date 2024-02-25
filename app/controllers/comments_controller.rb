class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def create
    @blog_post = BlogPost.find(params[:blog_post_id])
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

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
