class CreateSocietes < ActiveRecord::Migration[5.1]
  def change
    drop_table :societes
    create_table :societes do |t|
      t.string :nom_societe
      t.string :referent
      t.string :mail
      t.string :adresse
      t.integer :telephone
      t.timestamps
    end
  end
end
