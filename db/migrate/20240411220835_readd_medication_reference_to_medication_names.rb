class ReaddMedicationReferenceToMedicationNames < ActiveRecord::Migration[7.0]
  def change
    add_reference :medication_names, :medication, foreign_key: true
  end
end
