require "rails_helper"

RSpec.describe User, type: :model do
  subject { User.new(first_name: "Unit", last_name: "Test", account_type: "Admin", location: "Victoria General", email: "unit.test@email.com", password: "Test1234!") }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is valid if password is between 8 and 16 characters and matches format of atleast 1 number, symbol, uppercase and lowercase letter" do
    expect((subject.password).match?(/\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,16}\z/)).to eq(true)
  end

  it "is not valid without a first_name" do
    subject.first_name = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a last_name" do
    subject.last_name = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a location" do
    subject.account_type = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a location" do
    subject.location = nil
    expect(subject).to_not be_valid
  end

  it "is not valid with a email" do
    subject.location = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a password" do
    subject.location = nil
    expect(subject).to_not be_valid
  end

  it "is not valid if the password does not have a uppercase letter" do
    subject.password = "test1234!"
    expect(subject).to_not be_valid
  end

  it "is not valid if the password does not have a lowercase letter" do
    subject.password = "TEST1234!"
    expect(subject).to_not be_valid
  end

  it "is not valid if the password does not have a number" do
    subject.password = "TestPassword!"
    expect(subject).to_not be_valid
  end

  it "is not valid if the password does not have a symbol" do
    subject.password = "Test1234"
    expect(subject).to_not be_valid
  end

  it "is not valid if the password is less than 8 characters" do
    subject.password = "Test1!"
    expect(subject).to_not be_valid
  end

  it "is not valid if the password is more than 16 characters" do
    subject.password = "TestPassword1234!"
    expect(subject).to_not be_valid
  end

  context "User methods" do
    it "joins first and last name to create full name" do
      user = User.new(first_name: "John", last_name: "Doe")
      expect(user.full_name).to eq("John Doe")
    end
    it "identifies admin?" do
      user = User.new(account_type: "Admin")
      expect(user.admin?).to be_truthy
      expect(user.manager?).to be_falsey
      expect(user.doctor?).to be_falsey
      expect(user.nurse?).to be_falsey
      expect(user.care_worker?).to be_falsey
    end
    it "identifies manager?" do
      user = User.new(account_type: "Manager")
      expect(user.manager?).to be_truthy
      expect(user.admin?).to be_falsey
      expect(user.doctor?).to be_falsey
      expect(user.nurse?).to be_falsey
      expect(user.care_worker?).to be_falsey
    end
    it "identifies doctor?" do
      user = User.new(account_type: "Doctor")
      expect(user.doctor?).to be_truthy
      expect(user.admin?).to be_falsey
      expect(user.manager?).to be_falsey
      expect(user.nurse?).to be_falsey
      expect(user.care_worker?).to be_falsey
    end
    it "identifies nurse?" do
      user = User.new(account_type: "Nurse")
      expect(user.nurse?).to be_truthy
      expect(user.admin?).to be_falsey
      expect(user.manager?).to be_falsey
      expect(user.doctor?).to be_falsey
      expect(user.care_worker?).to be_falsey
    end
    it "identifies care_worker?" do
      user = User.new(account_type: "Care Worker")
      expect(user.care_worker?).to be_truthy
      expect(user.admin?).to be_falsey
      expect(user.manager?).to be_falsey
      expect(user.doctor?).to be_falsey
      expect(user.nurse?).to be_falsey
    end
  end
end
