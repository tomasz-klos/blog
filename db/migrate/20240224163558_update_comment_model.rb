class UpdateCommentModel < ActiveRecord::Migration[7.0]
  def change
    change_column :comments, :content, :text, null: false, default: ''
  end
end
