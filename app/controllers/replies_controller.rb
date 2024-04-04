class RepliesController < ApplicationController
  include ActionView::RecordIdentifier

  before_action :authenticate_user!, except: %i[show]
  before_action :set_comment, except: %i[show]
  before_action :authorize_user!, only: %i[edit update destroy]

  def new
    @reply = @comment.replies.build

    render(turbo_stream: turbo_stream.append(@comment,
                                             partial: 'replies/form',
                                             locals: { comment: @comment, reply: @reply }))
  end

  def create
    @reply = @comment.replies.build(reply_params(@comment.id))
    @reply.user_id = current_user.id
    @reply.comment_id = @comment.id

    respond_to do |format|
      if @reply.save
        format.turbo_stream do
          turbo_stream.prepend(dom_id(@comment, :replies),
                               partial: 'replies/reply',
                               locals: { reply: @reply })
          turbo_stream.replace(dom_id(@comment, :replies_count),
                               partial: 'replies/replies_count',
                               locals: { comment: @comment,
                                         replies: @comment.replies })
        end
      else
        format.turbo_stream do
          render(turbo_stream: turbo_stream.replace(@reply,
                                                    partial: 'replies/form',
                                                    locals: { comment: @comment, reply: @reply }))
        end
      end
    end
  end

  def edit
    @reply = @comment.replies.find(params[:id])

    render(turbo_stream: turbo_stream.replace(dom_id(@reply, :content),
                                              partial: 'replies/form',
                                              locals: {
                                                comment: @comment, reply: @reply
                                              }))
  end

  def update
    @reply = @comment.replies.find(params[:id])

    if @reply.update(reply_params(@comment.id))
      render(partial: 'replies/reply', locals: { reply: @reply })
    else
      render(partial: 'replies/form', locals: { comment: @comment, reply: @reply })
    end
  end

  def destroy
    @reply = @comment.replies.find(params[:id])
    @reply.destroy

    respond_to do |format|
      format.turbo_stream do
        turbo_stream.remove(@reply)
      end
    end
  end

  def toggle_like
    @reply = @comment.replies.find(params[:id])
    @reply.toggle_like(current_user)

    render(partial: 'replies/reply', locals: { reply: @reply })
  end

  private

  def reply_params(comment_id)
    params.require("reply_#{comment_id}").permit(:content)
  end

  def set_comment
    @comment = Comment.find(params[:comment_id])
  rescue ActiveRecord::RecordNotFound
    redirect_to(blog_posts_root_path)
  end

  def authorize_user!
    @reply = @comment.replies.find(params[:id])

    if @reply.user != current_user
      redirect_to(blog_posts_root_path, alert: 'You are not authorized to perform this action.')
      return false
    end
    true
  end
end
