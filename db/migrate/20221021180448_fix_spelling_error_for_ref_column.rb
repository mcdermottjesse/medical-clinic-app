class FixSpellingErrorForRefColumn < ActiveRecord::Migration[7.0]
  def change
    rename_column :client_medications, :client_logs_id, :client_log_id
  end
end
