class AddAnomalieToPlan < ActiveRecord::Migration[5.1]
  def change
    add_column :plan_action_types, :anomaly_id, :bigint
    add_foreign_key :plan_action_types, :anomalies
  end
end
