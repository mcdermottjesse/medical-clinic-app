class CreateClientMedication < ActiveRecord::Migration[7.0]
  def change
    create_table :client_medications do |t|
      t.references :client_logs
      t.string :medication_name
      
      t.timestamps
    end
  end
end
