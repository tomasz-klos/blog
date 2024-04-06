class CommentsController < ApplicationController
  include ActionView::RecordIdentifier

  before_action :authenticate_user!
  before_action :authorize_user!, only: %i[edit update destroy]

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id

    if @comment.save

      Turbo::StreamsChannel.broadcast_append_to('comments', target: 'comments',
                                                            partial: 'comments/comment',
                                                            locals: { author: false, comment: @comment, user: nil })

      Turbo::StreamsChannel.broadcast_replace_to(dom_id(@comment.user),
                                                 target: dom_id(@comment, :controls),
                                                 partial: 'comments/controls',
                                                 locals: { comment: @comment })

      users_except_author = User.where.not(id: @comment.user_id)

      users_except_author.each do |user|
        Turbo::StreamsChannel.broadcast_replace_to(dom_id(user),
                                                   target: dom_id(@comment, :likes),
                                                   partial: 'partials/like_form',
                                                   locals: { user:, target: @comment,
                                                             path: toggle_like_comment_path(@comment) })
      end

    else
      render(turbo_stream: turbo_stream.replace(@comment,
                                                partial: 'comments/form',
                                                locals: { post: @post, comment: @comment }))
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
      render(partial: 'comments/comment', locals: { author: true, comment: @comment, user: @comment.user })

      Turbo::StreamsChannel.broadcast_replace_later_to(dom_id(@comment, :content),
                                                       target: dom_id(@comment, :content),
                                                       partial: 'comments/content',
                                                       locals: { comment: @comment })
    else
      render(partial: 'comments/form', locals: { post: @comment.post, comment: @comment })
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    Turbo::StreamsChannel.broadcast_remove_to('comments', target: dom_id(@comment))
  end

  def toggle_like
    @comment = Comment.find(params[:id])

    return if @comment.user == current_user

    @comment.toggle_like(current_user)

    render(partial: 'comments/comment', locals: { author: false, comment: @comment, user: @comment.user })

    users_except_author = User.where.not(id: @comment.user_id)

    Turbo::StreamsChannel.broadcast_replace_to(dom_id(@comment, :like_count),
                                               target: dom_id(@comment, :like_count),
                                               partial: 'partials/like',
                                               locals: { target: @comment })

    users_except_author.each do |user|
      Turbo::StreamsChannel.broadcast_replace_to(dom_id(user),
                                                 target: dom_id(@comment, :likes),
                                                 partial: 'partials/like_form',
                                                 locals: { user:, target: @comment,
                                                           path: toggle_like_comment_path(@comment) })
    end
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
