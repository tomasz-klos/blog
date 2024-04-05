class Post::Component < ApplicationComponent
  option :post, Types.Instance(Post)

  def author?
    post.user == Current.user
  end
end
