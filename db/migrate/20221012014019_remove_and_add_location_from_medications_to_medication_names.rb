class RemoveAndAddLocationFromMedicationsToMedicationNames < ActiveRecord::Migration[7.0]
  def change
    remove_column :medications, :location, :string
    add_column :medication_names, :location, :string
  end
end
