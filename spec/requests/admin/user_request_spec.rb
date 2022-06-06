require "rails_helper"

RSpec.describe "admin/users", type: :request do
  include Devise::Test::IntegrationHelpers
  let(:valid_attributes) { 
    { first_name: "Valid", last_name: "Test", account_type: "Admin", location: "Victoria General", email: "valid.testt@email.com", password: "Test1234!" } 
  }
  let(:invite_user_attributes) { 
    { first_name: "Invite", last_name: "User", account_type: "Admin", location: "Victoria General", email: "new.user@email.com" } 
  }
  let(:new_user_attributes) { 
    { first_name: "Testtwo", last_name: "Usertwo", account_type: "Care Worker", location: "Victoria General", email: "test2.user2@email.com", password: "Test1234!" } 
  }
  let(:invalid_attributes) { 
    { first_name: "", last_name: "", account_type: "Nurse", location: "Royal Jubilee", email: "", password: "InvalidPassword" } 
  }

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
    context "valid paramaters" do
      it "creates a new User on invitation" do
        expect {
          post user_invitation_path, params: { user: invite_user_attributes }
        }.to change(User, :count).by(1)
      end
      it "redirects to home page after User invite and create" do
        post user_invitation_path, params: { user: invite_user_attributes }
        expect(response).to redirect_to(authenticated_root_path)
      end
    end
    context "invalid parameters" do
      it "does not create a new User" do
        expect {
          post user_invitation_path, params: { user: invalid_attributes }
        }.to change(User, :count).by(0)
      end
      it "renders a successful response on error" do
        post user_invitation_path, params: { user: invalid_attributes }
        expect(response).to be_successful
      end
    end
    context "unauthorized User" do
      it "does not create a new User if account type is unauthorized" do
        sign_out @user
        user = User.create! new_user_attributes
        sign_in user
        expect {
          post user_invitation_path, params: { user: invite_user_attributes }
        }.to change(User, :count).by(0)
      end
      it "redirects to Home page" do
        sign_out @user
        user = User.create! new_user_attributes
        sign_in user
        post user_invitation_path, params: { user: invite_user_attributes }
        expect(response).to redirect_to(authenticated_root_path)
      end
    end
  end

  describe "PATCH /update" do
    let(:updated_attributes) { { first_name: "Testupdate", last_name: "Userupdate", account_type: "Nurse", location: "Royal Jubilee", email: "edited@email.com" } }
    context "valid paramaters" do
      it "updates a user" do
        user = User.create! new_user_attributes
        patch admin_user_path(user), params: { user: updated_attributes }
        user.reload
        expect(user.first_name).to eq("Testupdate")
        expect(user.last_name).to eq("Userupdate")
        expect(user.account_type).to eq("Nurse")
        expect(user.location).to eq("Royal Jubilee")
        expect(user.email).to eq("edited@email.com")
      end
      it "redirects to User index after update" do
        user = User.create! new_user_attributes
        patch admin_user_path(user), params: { user: updated_attributes }
        user.reload
        expect(response).to redirect_to(admin_users_path)
      end
    end
    context "invalid parameters" do
      it "fails update a User" do
        user = User.create! new_user_attributes
        patch admin_user_path(user), params: { user: invalid_attributes }
        user.reload
        expect(user.location).to_not eq("Royal Jubilee")
        expect(user.location).to eq("Victoria General")
      end
      it "redirects to edit User page on failed update" do
        user = User.create! new_user_attributes
        patch admin_user_path(user), params: { user: invalid_attributes }
        expect(response).to redirect_to(edit_admin_user_path(user))
      end
    end
    context "unauthorized User" do
      it "does not update a User if account type is unauthorized" do
        sign_out @user
        user = User.create! new_user_attributes
        sign_in user
        patch admin_user_path(user), params: { user: updated_attributes }
        user.reload
        expect(user.location).to_not eq("Royal Jubilee")
        expect(user.location).to eq("Victoria General")
      end
      it "redirects to Home page" do
        sign_out @user
        user = User.create! new_user_attributes
        sign_in user
        post user_invitation_path, params: { user: updated_attributes }
        expect(response).to redirect_to(authenticated_root_path)
      end
    end
  end

  describe "DELETE /destroy" do
    context "authorized User" do
      it "destroys a User if account type is authorized" do
        user = User.create! new_user_attributes
        expect {
          delete admin_user_path(user)
        }.to change(User, :count).by(-1)
      end
      it "redirects to the User index page" do
        user = User.create! new_user_attributes
        delete admin_user_path(user)
        expect(response).to redirect_to(admin_users_path)
      end
    end
    context "unauthorized User" do
      it "does not destroy a User if account type is unauthorized" do
        sign_out @user
        user = User.create! new_user_attributes
        sign_in user
        expect {
          delete admin_user_path(user)
        }.to change(User, :count).by(0)
      end
      it "redirects to Home page" do
        sign_out @user
        user = User.create! new_user_attributes
        sign_in user
        delete admin_user_path(user)
        expect(response).to redirect_to(authenticated_root_path)
      end
    end
  end
end
