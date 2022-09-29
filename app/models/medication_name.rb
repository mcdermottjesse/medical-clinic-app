class MedicationName < ApplicationRecord
  belongs_to :medication
  
  validates_uniqueness_of :name
end