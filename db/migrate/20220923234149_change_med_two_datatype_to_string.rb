class ChangeMedTwoDatatypeToString < ActiveRecord::Migration[7.0]
  def change
    change_column :medications, :med_two, :string
  end
end
