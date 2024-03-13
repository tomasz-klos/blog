class RenamePolymorphicColumnsInLikes < ActiveRecord::Migration[7.0]
  def change
    rename_column :likes, :polymorphic_type, :likable_type
  end
end
