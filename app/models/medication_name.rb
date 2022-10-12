class MedicationName < ApplicationRecord
  belongs_to :medication
  
  validates_uniqueness_of :name, scope: :location # refer https://stackoverflow.com/questions/48266722/validate-uniqueness-of-a-value-with-scope-ruby-on-rails-5

  def self.search_medication(search)
    where("LOWER(name) LIKE :search", search: "%#{search.downcase}%")
  end
end