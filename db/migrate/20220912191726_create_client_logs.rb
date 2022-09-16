class CreateClientLogs < ActiveRecord::Migration[7.0]
  def change
    create_table :client_logs do |t|
      t.references :user 
      t.references :client
      t.text :doctor_log
      t.text :nurse_log

      t.timestamps 
    end
  end
end
