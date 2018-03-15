class CreatePlanActionTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :plan_action_types do |t|
      t.string :type
      t.text :descriptif
      t.string :liste_action
      t.datetime :temps
      t.string :priorite

      t.timestamps
    end
  end
end
