class CreateSocietes < ActiveRecord::Migration[5.1]
  def change
    create_table :societes do |t|
      t.string :nom
      t.string :referent_technique
      t.references :client, foreign_key: true
      t.references :anomalie, foreign_key: true

      t.timestamps
    end
  end
end
