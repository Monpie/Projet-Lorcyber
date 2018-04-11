class AddRoleToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :utilisateurs, :role, :string
  end
end
