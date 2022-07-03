class Client < ApplicationRecord
  class << self
    include Search
  end

  include Name, Location
end
