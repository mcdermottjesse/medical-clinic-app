User.create!(
  first_name: "Cypress",
  last_name: "Test",
  location: "Victoria General",
  email: "test@cypress.com",
  password: "Testonly1!",
  account_type: "Admin",
)

User.create!(
  first_name: "Second",
  last_name: "Test",
  location: "Nanaimo Regional",
  email: "second@cypress.com",
  password: "Testonly1!",
  account_type: "Admin",
)

User.create!(
  first_name: "Third",
  last_name: "Test",
  location: "Victoria General",
  email: "third@cypress.com",
  password: "Testonly1!",
  account_type: "Admin",
)

Client.create!(
  first_name: "First",
  last_name: "Last",
  avatar: Rack::Test::UploadedFile.new("spec/images/blank-profile-picture.png"),
  dob: "1975-07-22",
  pronoun: "She/Her",
  health_card_number: "1234-567-890",
  health_card_expiry: "2028-01-01",
  email: "first@email.com",
  phone_number: "(123) 456-7890",
  emergency_contact_name: "Emergency Person",
  emergency_contact_info: "(123) 456-7890",
  location: "Victoria General",
  bed_number: 3,
  general_info: "General info for First Last",
  consent: true,
)

Client.create!(
  first_name: "Second",
  last_name: "Last",
  avatar: Rack::Test::UploadedFile.new("spec/images/blank-profile-picture.png"),
  dob: "1995-03-14",
  pronoun: "She/Her",
  health_card_number: "1234-567-890",
  health_card_expiry: "2028-01-01",
  email: "second@email.com",
  phone_number: "(123) 456-7890",
  emergency_contact_name: "Emergency Person",
  emergency_contact_info: "(123) 456-7890",
  location: "Victoria General",
  bed_number: 30,
  general_info: "General info for Second Last",
  consent: true,
)

Client.create!(
  first_name: "Third",
  last_name: "Last",
  avatar: Rack::Test::UploadedFile.new("spec/images/blank-profile-picture.png"),
  dob: "2000-10-30",
  pronoun: "She/Her",
  health_card_number: "1234-567-890",
  health_card_expiry: "2028-01-01",
  email: "third@email.com",
  phone_number: "(123) 456-7890",
  emergency_contact_name: "Emergency Person",
  emergency_contact_info: "(123) 456-7890",
  location: "Royal Jubilee",
  bed_number: 20,
  general_info: "General info for Third Last",
  consent: true,
)
