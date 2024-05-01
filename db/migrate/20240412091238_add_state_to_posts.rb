class AddStateToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :aasm_state, :string
  end
end
