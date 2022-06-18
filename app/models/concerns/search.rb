module Search
  def search_record(search)
    where("LOWER(first_name) || ' ' || LOWER(last_name) LIKE :search", search: "%#{search.downcase}%")
  end
end
