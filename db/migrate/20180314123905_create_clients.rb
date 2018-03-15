class CreateClients < ActiveRecord::Migration[5.1]
  def change
    create_table :clients do |t|
      t.string :nom
      t.string :prenom
      t.string :mail
      t.string :adresse
      t.string :telephone

      t.timestamps
    end
  end
end
