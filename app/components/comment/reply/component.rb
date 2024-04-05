class Comment::Reply::Component < ApplicationComponent
  option :reply, Types.Instance(Reply)
  option :current_user, Types.Instance(User)

  def author?
    return false unless current_user

    reply.user == current_user
  end

  def author_of_post?
    !author? && (reply.comment.post.user == reply.user)
  end
end
