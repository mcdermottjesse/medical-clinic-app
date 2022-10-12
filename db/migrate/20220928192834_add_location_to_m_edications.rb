class AddLocationToMEdications < ActiveRecord::Migration[7.0]
  def change
    add_column :medications, :location, :string
  end
end
