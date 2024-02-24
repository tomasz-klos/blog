class Post::Component < ApplicationComponent
  option :post, Types.Instance(BlogPost)
end
