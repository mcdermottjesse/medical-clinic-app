class ClientLog < ApplicationRecord
  belongs_to :user
  belongs_to :client

  before_save :set_log_date

  def set_log_date
    self.log_date = Date.today
  end

end