class ChangeDosageAmountDataType < ActiveRecord::Migration[7.0]
  def change
    change_column :medications, :dosage_amount, :decimal, precision: 2, scale: 1
  end
end
