class Comment::Reply::Component < ApplicationComponent
  option :reply, Types.Instance(Reply)

  def author?
    return false unless Current.user

    reply.user == Current.user
  end

  def author_of_post?
    !author? && (reply.comment.post.user == reply.user)
  end
end
