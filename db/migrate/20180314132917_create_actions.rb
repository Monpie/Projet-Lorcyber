class CreateActions < ActiveRecord::Migration[5.1]
  def change
    create_table :actions do |t|
      t.datetime :date
      t.text :descriptif
      t.references :anomalie, foreign_key: true
      t.references :plan_action_types, foreign_key: true

      t.timestamps
    end
  end
end
