class RemoveColumnsFromMedications < ActiveRecord::Migration[7.0]
  def change
    rename_column :medications, :med_one, :name
    remove_column :medications, :med_two
    remove_column :medications, :med_three
    remove_column :medications, :med_four
    remove_column :medications, :med_five
    remove_reference :medications, :client_log, index: true
  end
end
