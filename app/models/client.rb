class Client < ApplicationRecord
  class << self
    include Search
  end

  include Name, Location

  before_create :generate_client_code

  PRONOUNS = ["She/Her", "They/Them", "He/Him", "Other"]

  
  def generate_client_code
    initials = first_name[0] + last_name[0]
    random_string = ([*('A'..'Z'), *('0'..'9')]).sample(4).join
    # * = splat operator, it destructures array
    self.client_code = initials + random_string
    if Client.pluck(:client_code).detect { |code| code == self.client_code }
      self.client_code = self.client_code.slice(0..1) + random_string
      # ^ will only generate new client code again once. therefore will still be created even if updated client code is duplicate again
      # explore how to keep regenerating client codes until they are unique
      # maybe add in birthday info (refer to trailer)
    end
  end
end
