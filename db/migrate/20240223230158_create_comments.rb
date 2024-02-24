class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.text :content
      t.references :blog_post, null: false, foreign_key: true
      t.references :parent_comment_id, foreign_key: { to_table: :comments }, optional: true

      t.timestamps
    end
  end
end
