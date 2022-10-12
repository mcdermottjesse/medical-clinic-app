class CreateMedicationNameTable < ActiveRecord::Migration[7.0]
  def change
    create_table :medication_names do |t|
      t.references :medication
      t.string :name

      t.timestamps
    end
  end
end
