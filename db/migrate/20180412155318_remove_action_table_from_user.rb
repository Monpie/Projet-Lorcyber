class RemoveActionTableFromUser < ActiveRecord::Migration[5.1]
  def change
    remove_foreign_key :utilisateurs, column: :action_id
    remove_column :utilisateurs, :action_id
  end
end
