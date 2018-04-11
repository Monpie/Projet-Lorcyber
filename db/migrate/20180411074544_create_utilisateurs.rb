class CreateUtilisateurs < ActiveRecord::Migration[5.1]
  def change
    create_table :utilisateurs do |t|
      t.string :nom
      t.string :password
      t.references :action, foreign_key: true

      t.timestamps
    end
  end
end
