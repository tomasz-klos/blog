class CreateLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :polymorphic, polymorphic: true, null: false

      t.timestamps
    end
  end
end
