class CommentsController < ApplicationController
  include ActionView::RecordIdentifier

  before_action :authenticate_user!, only: %i[create edit update destroy toggle_like]
  before_action :authorize_user!, only: %i[edit update destroy]

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id

    return if @comment.save

    respond_to do |format|
      format.turbo_stream do
        render(turbo_stream: turbo_stream.replace(@comment,
                                                  partial: 'comments/form',
                                                  locals: { comment: @comment }))
      end
    end
  end

  def edit
    @comment = Comment.find(params[:id])

    render(turbo_stream: turbo_stream.replace(dom_id(@comment, :content),
                                              partial: 'comments/form',
                                              locals: { post: @comment.post, comment: @comment }))
  end

  def update
    @comment = Comment.find(params[:id])

    if @comment.update(comment_params)
      render(partial: 'comments/comment', locals: { comment: @comment })
    else
      render(partial: 'comments/form', locals: { post: @comment.post, comment: @comment })
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.turbo_stream do
        turbo_stream.remove(@comment)
      end
    end
  end

  def toggle_like
    @comment = Comment.find(params[:id])
    @comment.toggle_like(current_user)

    render(partial: 'comments/comment', locals: { comment: @comment })
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def authorize_user!
    @comment = Comment.find(params[:id])
    return if @comment.user == current_user

    redirect_to(@post, alert: 'You are not authorized to perform this action.')
  end
end
