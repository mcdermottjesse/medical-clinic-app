class Client < ApplicationRecord
  class << self
    include Search
  end

  include Name, Location

  PRONOUNS = ["She/Her", "They/Them", "He/Him", "Other"]
end
