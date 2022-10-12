class AddDosageToMedications < ActiveRecord::Migration[7.0]
  def change
    add_column :medications, :dosage_amount, :integer
    add_column :medications, :dosage_unit, :string
  end
end
