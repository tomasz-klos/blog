class Post::Component < ApplicationComponent
  option :post, Types.Instance(Post)
  option :current_user, optional: true

  def author?
    post.user == current_user
  end
end
