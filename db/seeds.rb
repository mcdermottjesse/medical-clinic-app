# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

unless User.exists?
  User.create(
    first_name: "Cypress",
    last_name: "Test",
    location: "Victoria General",
    email: "test@cypress.com",
    password: "Testonly1!",
    account_type: "Admin",
  )
end

unless Client.exists?
  Client.create(
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
end