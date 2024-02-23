class RemoveBodyFromBlogPosts < ActiveRecord::Migration[7.0]
  def change
    remove_column :blog_posts, :body, :string
  end
end
