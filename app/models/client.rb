class Client < ApplicationRecord
  class << self
    include Search
  end

  include Name, Location

  attr_accessor :skip_consent_validation

  validates :first_name, :last_name, :dob, :location, :pronoun, :bed_number, presence: true

  validates :consent, presence: true, unless: :skip_consent_validation

  before_validation :format_health_number

  validates_format_of :health_card_number, with: /\A[0-9]{4}-[0-9]{3}-[0-9]{3}\z/, allow_blank: true # format = 1234-567-890

  before_validation :generate_client_code

  PRONOUNS = ["She/Her", "They/Them", "He/Him", "Other"]

  def format_health_number
    #insert hyphens if none are present but 10 numbers are included, else render validation error message
    regex_no_space = /\A([0-9]{4})([0-9]{3})([0-9]{3})\z/
    regex_with_space = /\A([0-9]{4}) ([0-9]{3}) ([0-9]{3})\z/
    if self.health_card_number.match(regex_no_space) || self.health_card_number.match(regex_with_space)
      self.health_card_number = [$1, $2, $3].join("-")
    end
  end

  def generate_client_code
    loop do
      self.client_code = first_name[0] + last_name[0] + ([*("A".."Z"), *("0".."9")]).sample(4).join + dob.strftime("%y")
      # * = splat operator, it destructures array
      break unless Client.pluck(:client_code).include?(self.client_code)

      # add error message if all code combinations have been used
    end
  end
end
