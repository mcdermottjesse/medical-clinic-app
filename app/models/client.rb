class Client < ApplicationRecord
  class << self
    include Search
  end

  include Name, Location

  validates :dob, presence: true

  before_create :generate_client_code

  PRONOUNS = ["She/Her", "They/Them", "He/Him", "Other"]

  def generate_client_code
    loop do
      self.client_code = first_name[0] + last_name[0] + ([*("A".."Z"), *("0".."9")]).sample(4).join + dob.strftime("%y")
      # * = splat operator, it destructures array
      break unless Client.pluck(:client_code).include?(self.client_code)

      # add error message if all code combinations have been used
    end
  end
end
