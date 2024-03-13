class Post::Component < ApplicationComponent
  option :post, Types.Instance(BlogPost)

  def author?
    post.user == Current.user
  end
end
