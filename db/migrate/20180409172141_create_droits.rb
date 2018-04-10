class CreateDroits < ActiveRecord::Migration[5.1]
  def change
    create_table :droits do |t|
      t.string :type
      t.references :utilisateurs, foreign_key: true

      t.timestamps
    end
  end
end
