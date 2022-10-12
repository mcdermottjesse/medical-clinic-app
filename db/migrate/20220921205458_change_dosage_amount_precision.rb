class ChangeDosageAmountPrecision < ActiveRecord::Migration[7.0]
  def change
    change_column :medications, :dosage_amount, :decimal
  end
end
