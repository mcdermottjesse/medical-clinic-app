class Client < ApplicationRecord
  class << self
    include Search
  end

  include Name, Location

  attr_accessor :skip_consent_validation

  validates :first_name, :last_name, :dob, :location, :pronoun, :health_card_expiry, :bed_number, :emergency_contact_name, presence: true

  validates :consent, presence: true, unless: :skip_consent_validation

  before_validation :format_health_number, :format_phone_number, :format_emergency_phone_number

  validates_format_of :health_card_number, with: /\A[0-9]{4}-[0-9]{3}-[0-9]{3}\z/, allow_blank: true # format = 1234-567-890

  validates_format_of :phone_number, :emergency_contact_info, with: /\A\(([0-9]{3}+)\) [0-9]{3}-[0-9]{4}\z/ # format = (123) 456-7890

  before_create :generate_client_code

  PRONOUNS = ['She/Her', 'They/Them', 'He/Him', 'Other']

  private

  def format_health_number
    correct_format = /\A[0-9]{4}-[0-9]{3}-[0-9]{3}\z/
    health_num_array = health_card_number.split('')

    if health_card_number !~ correct_format && health_num_array.length >= 10 && health_num_array.length <= 12
      self.health_card_number = self.health_card_number.gsub(/\W/, '').insert(4, '-') # gsub removes all symbols e.g '#$%^' etc
      self.health_card_number = self.health_card_number.insert(8, '-')
    end
  end

  def format_phone_number
    correct_format = /\A\(([0-9]{3}+)\) [0-9]{3}-[0-9]{4}\z/
    phone_num_array = phone_number.split('')

    if phone_number !~ correct_format && phone_num_array.length >= 10 && phone_num_array.length <= 14
      self.phone_number = self.phone_number.gsub(/\W/, '').insert(0, '(')
      self.phone_number = self.phone_number.insert(4, ')')
      self.phone_number = self.phone_number.insert(5, ' ')
      self.phone_number = self.phone_number.insert(9, '-')
    end
  end

  def format_emergency_phone_number
    correct_format = /\A\(([0-9]{3}+)\) [0-9]{3}-[0-9]{4}\z/
    emerg_phone_array = emergency_contact_info.split('')

    if emergency_contact_info !~ correct_format && emerg_phone_array.length >= 10 && emerg_phone_array.length <= 14
      self.emergency_contact_info = self.emergency_contact_info.gsub(/\W/, '').insert(0, '(')
      self.emergency_contact_info = self.emergency_contact_info.insert(4, ')')
      self.emergency_contact_info = self.emergency_contact_info.insert(5, ' ')
      self.emergency_contact_info = self.emergency_contact_info.insert(9, '-')
    end
  end

  def generate_client_code
    counter = 0
    loop do
      counter += 1
      
      self.client_code = first_name[0] + last_name[0] + ([*('A'..'Z'), *('0'..'9')]).sample(4).join + dob.strftime('%y')
      # * = splat operator, it destructures array
      
      raise "Could not find a unique Client Code. Please try again. If problem persists please contact Site Adminstrator" if counter > 100

      break unless Client.pluck(:client_code).include?(self.client_code)

    end
  end
end
