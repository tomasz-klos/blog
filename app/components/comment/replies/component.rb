class Comment::Replies::Component < ApplicationComponent
  include Comment::Replies

  option :replies
  option :comment, Types.Instance(Comment)
  option :user
end
