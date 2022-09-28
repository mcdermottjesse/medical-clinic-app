class RemoveNameFromMedication < ActiveRecord::Migration[7.0]
  def change
    remove_column :medications, :name
  end
end
