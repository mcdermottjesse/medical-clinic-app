class Client < ApplicationRecord
  class << self
    include Search
  end

  include Name, Location

  before_create :generate_client_code

  PRONOUNS = ["She/Her", "They/Them", "He/Him", "Other"]

  def generate_client_code
    self.client_code = first_name[0] + last_name[0] + ([*('A'..'Z'), *('0'..'9')]).sample(4).join
    # * = splat operator, it destructures an array
  end
end
