class CreateAnomalies < ActiveRecord::Migration[5.1]
  def change
    create_table :anomalies do |t|
      t.string :statut
      t.string :type
      t.datetime :date
      t.text :descriptif

      t.timestamps
    end
  end
end
