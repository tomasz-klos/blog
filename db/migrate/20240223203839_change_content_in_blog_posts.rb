class ChangeContentInBlogPosts < ActiveRecord::Migration[7.0]
  def change
    change_column :blog_posts, :content, :text
  end
end
