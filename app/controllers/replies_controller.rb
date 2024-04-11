class RepliesController < ApplicationController
  include ActionView::RecordIdentifier

  before_action(:authenticate_user!, except: %i[show])
  before_action(:set_comment, except: %i[show])
  before_action(:authorize_user!, only: %i[edit update destroy])

  def new
    @reply = @comment.replies.build

    render(turbo_stream: turbo_stream.append(dom_id(@comment, :replies),
                                             partial: 'replies/form',
                                             locals: { comment: @comment, reply: @reply }))
  end

  def create
    @reply = @comment.replies.build(reply_params(@comment.id))
    @reply.user_id = current_user.id
    @reply.comment_id = @comment.id

    if @reply.save
      Turbo::StreamsChannel.broadcast_append_to(dom_id(@comment, :replies),
                                                target: dom_id(@comment, :replies),
                                                partial: 'replies/reply',
                                                locals: { author: nil, reply: @reply, user: nil })

      Turbo::StreamsChannel.broadcast_replace_to(dom_id(@reply.user),
                                                 target: dom_id(@reply, :controls),
                                                 partial: 'partials/comment_controls',
                                                 locals: { record: @reply })

      Turbo::StreamsChannel.broadcast_replace_to(dom_id(@comment, :replies_count),
                                                 target: dom_id(@comment, :replies_count),
                                                 partial: 'replies/replies_count',
                                                 locals: {
                                                   comment: @comment,
                                                   replies: @comment.replies
                                                 })

      users_except_author = User.where.not(id: @reply.user_id)

      users_except_author.each do |user|
        Turbo::StreamsChannel.broadcast_replace_to(dom_id(user),
                                                   target: dom_id(@reply, :likes),
                                                   partial: 'partials/like_form',
                                                   locals: { user:, target: @reply,
                                                             path: toggle_like_comment_reply_path(@comment, @reply) })
      end
    else
      respond_to do |format|
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
                                              locals: { comment: @comment, reply: @reply }))
  end

  def update
    @reply = @comment.replies.find(params[:id])

    if @reply.update(reply_params(@comment.id))
      render(partial: 'replies/reply', locals: { author: true, reply: @reply, user: @reply.user })

      Turbo::StreamsChannel.broadcast_replace_to(dom_id(@reply, :content),
                                                 target: dom_id(@reply, :content),
                                                 partial: 'partials/comment_content',
                                                 locals: { record: @reply, user: @reply.user })
    else
      render(partial: 'replies/form', locals: { comment: @comment, reply: @reply })
    end
  end

  def destroy
    @reply = @comment.replies.find(params[:id])
    @reply.destroy

    Turbo::StreamsChannel.broadcast_remove_to(dom_id(@comment, :replies),
                                              target: dom_id(@reply))

    Turbo::StreamsChannel.broadcast_replace_to(dom_id(@comment, :replies_count),
                                               target: dom_id(@comment, :replies_count),
                                               partial: 'replies/replies_count',
                                               locals: { comment: @comment, replies: @comment.replies })
  end

  def toggle_like
    @reply = @comment.replies.find(params[:id])

    return if @reply.user == current_user

    @reply.toggle_like(current_user)

    render(partial: 'replies/reply', locals: { author: false, reply: @reply, user: current_user, replies: nil })

    users_except_author = User.where.not(id: @reply.user_id)

    Turbo::StreamsChannel.broadcast_replace_to(dom_id(@reply, :like_count),
                                               target: dom_id(@reply, :like_count),
                                               partial: 'partials/like',
                                               locals: { target: @reply })

    users_except_author.each do |user|
      Turbo::StreamsChannel.broadcast_replace_to(dom_id(user),
                                                 target: dom_id(@reply, :likes),
                                                 partial: 'partials/like_form',
                                                 locals: { user:, target: @reply,
                                                           path: toggle_like_comment_reply_path(@comment, @reply) })
    end
  end

  private

  def reply_params(comment_id)
    params.require("reply_#{comment_id}").permit(:content)
  end

  def set_comment
    @comment = Comment.find(params[:comment_id])
  rescue ActiveRecord::RecordNotFound
    redirect_to(posts_root_path)
  end

  def authorize_user!
    @reply = @comment.replies.find(params[:id])

    if @reply.user != current_user
      redirect_to(posts_root_path, alert: 'You are not authorized to perform this action.')
      return false
    end
    true
  end
end
