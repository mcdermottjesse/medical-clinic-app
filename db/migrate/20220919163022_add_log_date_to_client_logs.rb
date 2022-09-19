class AddLogDateToClientLogs < ActiveRecord::Migration[7.0]
  def change
    add_column :client_logs, :log_date, :date
  end
end
