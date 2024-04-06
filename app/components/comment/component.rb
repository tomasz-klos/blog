class Comment::Component < ApplicationComponent
  option :author, default: false
  option :comment, Types.Instance(Comment)
  option :user, Types.Instance(User)

  def author_of_post?
    comment.post.user == comment.user
  end
end
