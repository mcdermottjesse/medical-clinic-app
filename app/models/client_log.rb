class ClientLog < ApplicationRecord
  belongs_to :user
  belongs_to :client

  has_many :medications

  accepts_nested_attributes_for :medications, reject_if: proc { |med_attr| med_attr["name"].blank? || med_attr["dosage_amount"].blank? || med_attr["dosage_unit"].blank? }
end
