module ValidationMessage

  def first_name_validation
    errors.full_messages_for(:first_name).join("")
  end

  def last_name_validation
    errors.full_messages_for(:last_name).join("")
  end

  def avatar_validation
    "Must include photo of client" if errors[:avatar].any?
  end

  def dob_validation
    if dob.present? && dob > Date.today
      errors.add(:dob, message: "must be in the past")
      errors.full_messages_for(:dob)[0]
    else
      errors.full_messages_for(:dob).join("")
    end
  end

  def pronoun_validation
    errors.full_messages_for(:pronoun).join("")
  end

  def other_pronoun_validation
    errors.full_messages_for(:other_pronoun).join("")
  end

  def health_card_number_validation
    errors.full_messages_for(:health_card_number).join("")
  end

  def health_card_expiry_validation
    if health_card_expiry.present? && health_card_expiry < Date.tomorrow
      errors.add(:health_card_expiry, message: "must be in the future")
      errors.full_messages_for(:health_card_expiry)[0]
    else
      errors.full_messages_for(:health_card_expiry).join("")
    end
  end

  def phone_validation
    errors.full_messages_for(:phone_number).join("")
  end

  def emergency_contact_name_validation
    errors.full_messages_for(:emergency_contact_name).join("")
  end

  def emergency_contact_info_validation
    errors.full_messages_for(:emergency_contact_info).join("")
  end

  def location_validation
    errors.full_messages_for(:location).join("")
  end

  def bed_number_validation
    errors.full_messages_for(:bed_number).join("")
  end

  def consent_validation
    errors.full_messages_for(:consent).join("")
  end
  
end