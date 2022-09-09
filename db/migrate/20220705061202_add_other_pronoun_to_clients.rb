class AddOtherPronounToClients < ActiveRecord::Migration[7.0]
  def change
    add_column :clients, :other_pronoun, :string
  end
end
