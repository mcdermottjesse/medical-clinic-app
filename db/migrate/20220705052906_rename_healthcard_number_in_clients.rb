class RenameHealthcardNumberInClients < ActiveRecord::Migration[7.0]
  def change
    rename_column :clients, :healthcard_number, :health_card_number
  end
end
