class Comment::Component < ApplicationComponent
  option :comment, Types.Instance(Comment)
  option :current_user, Types.Instance(User)

  def author?
    return false unless current_user

    comment.user == current_user
  end

  def author_of_post?
    !author? && (comment.post.user == comment.user)
  end
end
