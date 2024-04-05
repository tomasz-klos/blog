class RenameBlogPostIdToPostIdInComments < ActiveRecord::Migration[6.0]
  def change
    rename_column :comments, :blog_post_id, :post_id
  end
end
