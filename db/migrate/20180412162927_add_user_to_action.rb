class AddUserToAction < ActiveRecord::Migration[5.1]
  def change
    add_column :actions, :utilisateur_id, :bigint
    add_foreign_key :actions, :utilisateurs
  end
end
