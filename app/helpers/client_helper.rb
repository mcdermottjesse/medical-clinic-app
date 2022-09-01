module ClientHelper
  def display_content_if_present
    @client.other_pronoun.present? ? @client_pronoun = @client.other_pronoun : @client_pronoun = @client.pronoun
    @health_card_number_label = "Health Number: " if @client.health_card_number.present?
    @health_card_expiry_label = "Health Card Expiry: " if @client.health_card_expiry.present?
    @email_label = "Email: " if @client.email.present?
    @general_info_label = "General Info: " if @client.general_info.present? 
  end
end