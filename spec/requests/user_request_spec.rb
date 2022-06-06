require "rails_helper"

RSpec.describe "admin/users", type: :request do
  include Devise::Test::IntegrationHelpers
  let(:valid_attributes) { { first_name: "Valid", last_name: "Test", account_type: "Admin", location: "Victoria General", email: "valid.testt@email.com", password: "Test1234!" } }
  let(:invite_user_attributes) { { first_name: "Invite", last_name: "User", account_type: "Admin", location: "Victoria General", email: "new.user@email.com" } }
  let(:new_user_attributes) { { first_name: "Testtwo", last_name: "Usertwo", account_type: "Admin", location: "Victoria General", email: "test2.user2@email.com", password: "Test1234!" } }
  let(:invalid_attributes) { { first_name: "Invalid", last_name: "User", account_type: "Care Worker", location: "Victoria General", email: "invalid.usert@email.com", password: "PasswordInvalid" } }

  before do
    @user = User.create! valid_attributes
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

  describe "POST /create" do
    it "creates a user with valid parameters on invitation" do
      expect {
        post user_invitation_path, params: { user: invite_user_attributes }
      }.to change(User, :count).by(1)
    end
    it "redirects to home page after invite and create" do
      post user_invitation_path, params: { user: invite_user_attributes }
      expect(response).to redirect_to(authenticated_root_path)
    end
  end

  describe "PATCH /update" do
    let(:updated_attributes) { { first_name: "Testupdate" } }
    it "updates a user" do
      user = User.create! new_user_attributes
      patch admin_user_path(user), params: { user: updated_attributes }
      user.reload
      expect(user.first_name).to eq("Testupdate")
    end
  end
  # add invalid attributes tests
end
