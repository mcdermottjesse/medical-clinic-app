class ClientLog < ApplicationRecord
  belongs_to :user
  belongs_to :client

  has_many :client_medications

  accepts_nested_attributes_for :client_medications, reject_if: lambda { |attribute| attribute[:medication_name].blank? }
end
