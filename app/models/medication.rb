class Medication < ApplicationRecord
  has_many :medication_names, dependent: :destroy

  accepts_nested_attributes_for :medication_names, reject_if: lambda { |attribute| attribute[:name].blank? }

  def self.search_medication(search)
    joins(:medication_names).where("LOWER(medication_names.name) LIKE :search", search: "%#{search.downcase}%")
  end
end