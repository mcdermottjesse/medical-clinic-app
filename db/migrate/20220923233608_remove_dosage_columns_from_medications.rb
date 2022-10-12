class RemoveDosageColumnsFromMedications < ActiveRecord::Migration[7.0]
  def change
    rename_column :medications, :name, :med_one
    rename_column :medications, :dosage_amount, :med_two
    rename_column :medications, :dosage_unit, :med_three
    add_column :medications, :med_four, :string
    add_column :medications, :med_five, :string
  end
end
