class AddKeyToAnomalie < ActiveRecord::Migration[5.1]
  def change
    add_column :anomalies, :societe_id, :bigint
    add_foreign_key :anomalies, :societes
  end
end
