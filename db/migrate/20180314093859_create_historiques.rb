class CreateHistoriques < ActiveRecord::Migration[5.1]
  def change
    create_table :historiques do |t|
      t.datetime :date
      t.text :evenements
      t.string :utilisateur

      t.timestamps
    end
  end
end
