class Comment::Replies::Component < ApplicationComponent
  option :replies
  option :comment, Types.Instance(Comment)
end
