class Post::Component < ApplicationComponent
  option :post, Types.Instance(BlogPost)
  option :current_user, Types.Instance(User)

  def author?
    post.user == current_user
  end
end
