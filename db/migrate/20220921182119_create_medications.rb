class CreateMedications < ActiveRecord::Migration[7.0]
  def change
    create_table :medications do |t|
      t.references :client_log
      t.string :name

      t.timestamps
    end
  end
end
