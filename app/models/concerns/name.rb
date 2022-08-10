module Name
  def full_name
    [first_name, last_name].join(" ")
  end
  def capitalize_name
    self.first_name = first_name.titleize
    self.last_name  = last_name.titleize
  end
end
