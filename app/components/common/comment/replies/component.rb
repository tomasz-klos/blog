class Common::Comment::Replies::Component < ApplicationComponent
  include Common::Comment::Replies

  option :replies
  option :comment, Types.Instance(Comment)
  option :user
end
