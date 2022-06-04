require "rails_helper"

RSpec.describe User, type: :model do
  subject { User.new(first_name: "Unit", last_name: "Test") }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end
end
