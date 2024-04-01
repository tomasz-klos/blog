class Comment::Replies::Component < ApplicationComponent
  option :replies
  option :comment, Types.Instance(Comment)
  option :current_user, Types.Instance(User)
end
