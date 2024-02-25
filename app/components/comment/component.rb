class Comment::Component < ApplicationComponent
  option :comment, Types.Instance(Comment)

  def author?
    return false unless Current.user

    comment.user == Current.user
  end
end
