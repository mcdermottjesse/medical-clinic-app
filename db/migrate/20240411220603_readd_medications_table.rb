class ReaddMedicationsTable < ActiveRecord::Migration[7.0]
  def change
    create_table :medications do |t|
      t.timestamps
    end
  end
end
