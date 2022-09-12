require "rails_helper"

RSpec.describe "clients", type: :request do
  include Devise::Test::IntegrationHelpers

  let(:valid_user) {
    { first_name: "Valid", last_name: "Test", account_type: "Admin", location: "Victoria General", email: "valid.test@email.com", password: "Test1234!" }
  }

  let(:invalid_user) {
    { first_name: "Invalid", last_name: "User", account_type: "Care Worker", location: "Victoria General", email: "invalid.test@email.com", password: "Test1234!" }
  }

  let(:valid_client) {
    { 
      client_code: "TC123B92",
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

  let(:new_client) {
    { 
      id: 2,
      client_code: "NC321C90",
      first_name: "New", 
      last_name: "Client",
      avatar: Rack::Test::UploadedFile.new('spec/images/blank-profile-picture.png'),
      dob: "1990-05-10", 
      pronoun: "She/Her",
      health_card_number: "0987-654-321", 
      health_card_expiry: "2027-01-01", 
      email: "newclient@email.com", 
      phone_number: "(098) 765-4321", 
      emergency_contact_name: "New Person",
      emergency_contact_info: "(098) 765-4321",
      location: "Royal Jubilee",
      bed_number: 5,
      general_info: "General info for New Client",
      consent: true
    }
  }

  let(:invalid_client) { { id: 3, client_code: "NC321C90", first_name: "", last_name: "", dob: "", location: "Saanich Peninsula", consent: true } }

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

  describe "POST /create" do
    context "valid paramaters" do
      it "creates a new Client" do
        expect {
          post clients_path, params: { client: new_client }
        }.to change(Client, :count).by(1)
      end
      it "redirects to clients index page after Client create" do
        post clients_path, params: { client: new_client }
        expect(response).to redirect_to(client_path(new_client[:id], location: new_client[:location]))
      end
    end
    context "invalid parameters" do
      it "does not create a new client" do
        expect {
          post clients_path, params: { client: invalid_client }
        }.to change(Client, :count).by(0)
      end
      it "renders a successful response on error" do
        post clients_path, params: { client: invalid_client }
        expect(response).to be_successful
      end
    end
    context "unauthorized User" do
      it "does not create a new Client if User account type is unauthorized" do
        sign_out @user
        user = User.create! invalid_user
        sign_in user
        expect {
          post clients_path, params: { client: valid_client, location: valid_client[:location]}
        }.to change(Client, :count).by(0)
      end
      it "redirects to Home page" do
        sign_out @user
        user = User.create! invalid_user
        sign_in user
        post clients_path, params: { client: valid_client, location: valid_client[:location] }
        expect(response).to redirect_to(authenticated_root_path)
      end
    end
  end

  describe "PATCH /update" do
    let(:updated_attributes) {
      { 
        id: 1,
        client_code: "TC123B92",
        first_name: "Testupdate", 
        last_name: "Clientupdate",
        avatar: Rack::Test::UploadedFile.new('spec/images/blank-profile-picture.png'),
        dob: "1992-04-10", 
        pronoun: "He/Him",
        health_card_number: "1111-222-333", 
        health_card_expiry: "2030-01-01", 
        email: "updateclient@email.com", 
        phone_number: "(999) 444-0000", 
        emergency_contact_name: "Emergency Person",
        emergency_contact_info: "(123) 456-7890",
        location: "Victoria General",
        bed_number: 9,
        general_info: "General info for Test Client updated",
        consent: true
      }
    }
    context "valid paramaters" do
      it "updates a client" do
        # updating valid_client which has id: 1
        patch client_path(@client), params: { client: updated_attributes }
        @client.reload
        expect(@client.first_name).to eq("Testupdate")
        expect(@client.last_name).to eq("Clientupdate")
        expect(@client.pronoun).to eq("He/Him")
        expect(@client.health_card_number).to eq("1111-222-333")
        expect(@client.health_card_expiry).to eq(Date.parse("2030-01-01"))
        expect(@client.email).to eq("updateclient@email.com")
        expect(@client.phone_number).to eq("(999) 444-0000")
        expect(@client.bed_number).to eq(9)
        expect(@client.location).to eq("Victoria General")
        expect(@client.general_info).to eq("General info for Test Client updated")
      end
      it "redirects to Client show after update" do
        patch client_path(@client), params: { client: updated_attributes }
        @client.reload
        expect(response).to redirect_to(client_path(@client, location: updated_attributes[:location]))
      end
    end
    context "invalid parameters" do
      it "fails to update a Client" do
        patch client_path(@client), params: { client: invalid_client }
        @client.reload
        expect(@client.location).to_not eq("Saanich Peninsula")
        expect(@client.location).to eq("Victoria General")
        expect(@client.first_name).to eq("Test")
      end
      it "renders a successful response on error" do
        patch client_path(@client), params: { client: invalid_client }
        expect(response).to be_successful
      end
    end
     context "unauthorized User" do
      it "does not update a Client if User account type is unauthorized" do
        sign_out @user
        user = User.create! invalid_user
        sign_in user
        patch client_path(@client), params: { client: updated_attributes, location: updated_attributes[:location]}
        @client.reload
        expect(@client.first_name).to_not eq("Testupdate")
        expect(@client.first_name).to eq("Test")
      end
      it "redirects to Home page" do
        sign_out @user
        user = User.create! invalid_user
        sign_in user
        patch client_path(@client), params: { client: updated_attributes, location: updated_attributes[:location] }
        expect(response).to redirect_to(authenticated_root_path)
      end
    end
  end
  describe "DELETE /destroy" do
    context "Can destroy a Client" do
      it "destroys a Client" do
        expect {
          delete client_path(@client)
        }.to change(Client, :count).by(-1)
      end
      it "redirects to the Client index page" do
        delete client_path(@client)
        expect(response).to redirect_to(clients_path)
      end
    end
    context "unauthorized User" do
      it "does not destroy a Client if User account type is unauthorized" do
        sign_out @user
        user = User.create! invalid_user
        sign_in user
        expect {
          delete client_path(@client)
        }.to change(Client, :count).by(0)
      end
      it "redirects to Home page" do
        sign_out @user
        user = User.create! invalid_user
        sign_in user
        delete client_path(@client)
        expect(response).to redirect_to(authenticated_root_path)
      end
    end
  end
end