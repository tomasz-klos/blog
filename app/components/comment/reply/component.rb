class Comment::Reply::Component < ApplicationComponent
  option :author, default: false
  option :reply, Types.Instance(Reply)
  option :user, Types.Instance(User)

  def author_of_post?
    reply.comment.post.user == reply.user
  end
end
