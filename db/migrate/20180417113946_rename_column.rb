class RenameColumn < ActiveRecord::Migration[5.1]
  def change
    rename_column :plan_action_types, :type, :incident_type
  end
end
