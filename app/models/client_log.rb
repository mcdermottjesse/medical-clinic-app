class ClientLog < ApplicationRecord
  belongs_to :user
  belongs_to :client

  has_many :medications

  accepts_nested_attributes_for :medications
end
