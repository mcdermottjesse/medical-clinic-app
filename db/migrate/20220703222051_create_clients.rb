class CreateClients < ActiveRecord::Migration[7.0]
  def change
    create_table :clients do |t|
      t.string :client_code
      t.string :first_name
      t.string :last_name
      t.date :dob
      t.string :pronoun
      t.string :healthcard_number
      t.date :health_card_expiry
      t.string :email
      t.string :phone_number
      t.string :emergency_contact_name
      t.string :emergency_contact_info
      t.string :location
      t.integer :bed_number
      t.text :general_info
      t.boolean :consent

      t.timestamps
    end
  end
end
