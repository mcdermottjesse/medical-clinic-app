require "rails_helper"

RSpec.describe "admin/users", type: :request do
  include Devise::Test::IntegrationHelpers
  before do
    @user = User.create(first_name: "Unit", last_name: "Test", account_type: "Admin", location: "Victoria General", email: "unit.test@email.com", password: "Test1234!")
    sign_in @user
  end

  describe "GET /index" do
    it "renders a successful response" do
      get admin_users_path
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_user_invitation_path
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      get edit_admin_user_path(@user)
      expect(response).to be_successful
    end
  end

  describe "Post /create" do 
    it "creates a user" do
      expect {
      post user_invitation_path, params: { user: { first_name: "Test", last_name: "User", account_type: "Admin", location: "Victoria General", email: "test.user@email.com"} }
      }.to change(User, :count).by(1)
    end
  end
end
