require "rails_helper"

RSpec.describe "clients", type: :request do
  include Devise::Test::IntegrationHelpers

  let(:valid_user) {
    { first_name: "Valid", last_name: "Test", account_type: "Admin", location: "Victoria General", email: "valid.testt@email.com", password: "Test1234!" }
  }

  let(:valid_client) {
    { 
      first_name: "Test", 
      last_name: "Client",
      avatar: Rack::Test::UploadedFile.new('spec/images/blank-profile-picture.png'),
      dob: "1992-04-10", 
      pronoun: "She/Her",
      health_card_number: "1234-567-890", 
      health_card_expiry: "2026-01-01", 
      email: "testclient@email.com", 
      phone_number: "(123) 456-7890", 
      emergency_contact_name: "Emergency Person",
      emergency_contact_info: "(123) 456-7890",
      location: "Victoria General",
      bed_number: 11,
      general_info: "General info for Test Client",
      consent: true
    }
  }

  before do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean
    @user = User.create! valid_user
    @client = Client.create! valid_client
    sign_in @user
  end

  describe "GET /index" do
    it "renders a successful response" do
      get clients_path
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_client_path
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      get edit_client_path(@client)
      expect(response).to be_successful
    end
  end
end