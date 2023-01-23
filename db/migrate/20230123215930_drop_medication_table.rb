class DropMedicationTable < ActiveRecord::Migration[7.0]
  def up
    remove_index :medication_names, :medication_id
    remove_column :medication_names, :medication_id
    drop_table :medications
  end
  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
