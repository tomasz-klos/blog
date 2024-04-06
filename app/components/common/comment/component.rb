class Common::Comment::Component < ApplicationComponent
  include Common::Comment

  option :author, default: false
  option :record
  option :user, Types.Instance(User)
  option :replies

  def author_of_post?
    if record.is_a?(Comment)
      record.post.user == record.user
    else
      record.comment.post.user == record.user
    end
  end
end
