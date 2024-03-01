class RepliesController < ApplicationController
  before_action :authenticate_user!, except: %i[show]
  before_action :set_comment, except: %i[show]
  before_action :authorize_user!, except: %i[show]

  def new
    @reply = @comment.replies.build

    render turbo_stream: turbo_stream.append(@comment, partial: 'replies/form',
                                                       locals: { comment: @comment, reply: @reply })
  end

  def create
    @reply = @comment.replies.build(reply_params)
    @reply.user_id = current_user.id
    @reply.comment_id = @comment.id

    puts "reply: #{@reply.inspect}"

    respond_to do |format|
      if @reply.save
        puts "reply saved #{@reply.inspect}"
        format.turbo_stream do
          turbo_stream.prepend("replies_#{@comment_id}", partial: 'replies/reply',
                                          locals: { reply: @reply })
        end
      else

        puts "reply not saved #{@reply}"
        puts "reply errors: #{@reply.errors.full_messages}"
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(@reply, partial: 'replies/form',
                                                                    locals: { reply: @reply })
        end
      end
    end
  end

  def edit
    @reply = @comment.replies.find(params[:id])

    render turbo_stream: turbo_stream.replace(@reply, partial: 'replies/form',
                                                              locals: { reply: @reply })
  end

  def update
    @reply = @comment.replies.find(params[:id])

    puts "reply_params: #{reply_params}"
    puts "reply: #{@reply.inspect}"

    if @reply.update(reply_params)

      respond_to do |format|
        format.turbo_stream do
          turbo_stream.append("replies_#{@comment_id}", partial: 'replies/reply',
                                         locals: { reply: @reply })
        end
      end
    else
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(@reply, partial: 'replies/form',
                                                                    locals: { reply: @reply })
        end
      end
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

  private

  def reply_params
    puts "reply params: #{params}"
    params.require(:reply).permit(:content)
  end

  def set_comment
    @comment = Comment.find(params[:comment_id])
  rescue ActiveRecord::RecordNotFound
    redirect_to blog_posts_root_path
  end

  def authorize_user!
    nil if @comment.user == current_user
  end
end
