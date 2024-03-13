class RemovePolymorphicIdInLikes < ActiveRecord::Migration[7.0]
  def change
    remove_column :likes, :polymorphic_id
  end
end
