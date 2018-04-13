class AddRoleToUser < ActiveRecord::Migration[5.1]
  def change
    #remove_column :utilisateurs, :role
    add_column :utilisateurs, :droit_id, :bigint
    add_foreign_key :utilisateurs, :droits
  end
end
