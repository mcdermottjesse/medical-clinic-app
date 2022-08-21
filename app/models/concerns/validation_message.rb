module ValidationMessage

  def first_name_validation
    self.errors.full_messages_for(:first_name).join("")
  end

  def last_name_validation
    self.errors.full_messages_for(:last_name).join("")
  end

  def dob_validation
    self.errors.full_messages_for(:dob).join("")
  end

  def pronoun_validation
    self.errors.full_messages_for(:pronoun).join("")
  end

  def other_pronoun_validation
    self.errors.full_messages_for(:other_pronoun).join("")
  end

  def health_card_number_validation
    self.errors.full_messages_for(:health_card_number).join("")
  end

  def health_card_expiry_validation
    self.errors.full_messages_for(:health_card_expiry).join("")
  end

  def phone_validation
    self.errors.full_messages_for(:phone_number).join("")
  end

  def emergency_contact_name_validation
    self.errors.full_messages_for(:emergency_contact_name).join("")
  end

  def emergency_contact_info_validation
    self.errors.full_messages_for(:emergency_contact_info).join("")
  end

  def location_validation
    self.errors.full_messages_for(:location).join("")
  end

  def bed_number_validation
    self.errors.full_messages_for(:bed_number).join("")
  end

  def consent_validation
    self.errors.full_messages_for(:consent).join("")
  end
  
end