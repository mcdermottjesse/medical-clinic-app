class MedicationName < ApplicationRecord
  belongs_to :medication
  
  validates_uniqueness_of :name, scope: :location # only validates if same location

  def self.search_medication(search)
    where("LOWER(name) LIKE :search", search: "%#{search.downcase}%")
  end
end