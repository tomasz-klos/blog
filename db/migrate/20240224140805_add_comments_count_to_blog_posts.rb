class AddCommentsCountToBlogPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :blog_posts, :comments_count, :integer
  end
end
