require "rails_helper"

RSpec.describe Client, type: :model do
  subject {
    Client.new(
      id: 1,
      first_name: "Unit",
      last_name: "Client",
      avatar: Rack::Test::UploadedFile.new("spec/images/blank-profile-picture.png"),
      dob: "1991-04-10",
      pronoun: "They/Them",
      health_card_number: "1234-567-890",
      health_card_expiry: "2028-01-01",
      email: "unitclient@email.com",
      phone_number: "(123) 456-7890",
      emergency_contact_name: "Emergency Person",
      emergency_contact_info: "(123) 456-7890",
      location: "Royal Jubilee",
      bed_number: 19,
      general_info: "General info for Unit Client",
      consent: true,
    )
  }

  # using let instead of Client.create! here stops test db from populating.
  let(:client_attributes) {
    {
      first_name: "Create",
      last_name: "Client",
      avatar: Rack::Test::UploadedFile.new("spec/images/blank-profile-picture.png"),
      dob: "1989-01-01",
      pronoun: "Other",
      other_pronoun: "Something else",
      health_card_number: "(123)4567890",
      health_card_expiry: "2028-01-01",
      email: "createclient@email.com",
      phone_number: "123-456-7890",
      emergency_contact_name: "Emergency Person",
      emergency_contact_info: "1234.567.890",
      location: "Royal Jubilee",
      bed_number: 17,
      general_info: "General info for Create Client",
      consent: true,
    }
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is valid if health card number is formatted as 1234-567-890" do
    expect((subject.health_card_number).match?(/\A[0-9]{4}-[0-9]{3}-[0-9]{3}\z/)).to eq(true)
  end

  it "is valid if phone number is formatted as (123) 456-7890" do
    expect((subject.phone_number).match?(/\A\(([0-9]{3}+)\) [0-9]{3}-[0-9]{4}\z/)).to eq(true)
  end

  it "is valid if emergency contact info is formatted as (123) 456-7890" do
    expect((subject.emergency_contact_info).match?(/\A\(([0-9]{3}+)\) [0-9]{3}-[0-9]{4}\z/)).to eq(true)
  end

  it "client code is formatted with 8 numbers/letters which includes Client initials and dob" do
    client = Client.create! client_attributes
    expect(client.client_code).to_not be_nil
    expect(client.client_code.length).to be (8)
    expect(client.client_code).to include("CC")
    expect(client.client_code).to include("89")
  end

  it "is not valid without a first_name" do
    subject.first_name = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a last_name" do
    subject.last_name = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a avatar" do
    subject.avatar = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a dob" do
    subject.dob = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a pronoun" do
    subject.pronoun = nil
    expect(subject).to_not be_valid
  end

  it "will not validate other pronoun if pronoun selected is 'Other'" do
    subject.pronoun = "Other"
    expect(subject).to_not be_valid
  end

  it "will clear other pronoun value if pronoun is switched from 'Other' to a different value" do
    client = Client.create! client_attributes
    client.update!(pronoun: "They/Them")
    expect(client.other_pronoun).to be_nil
  end

  it "is not valid without a emergency contact name" do
    subject.emergency_contact_name = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a location" do
    subject.location = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a bed number" do
    subject.bed_number = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without consent" do
    subject.consent = nil
    expect(subject).to_not be_valid
  end

  context "Client methods" do
    it "joins first and last name to create full name" do
      expect(subject.full_name).to eq("Unit Client")
    end

    it "will format health card number correctly and remove symbols if formatted without letters and has a length >= 10 <= 12" do
      # original input (123)4567890
      client = Client.create! client_attributes
      expect(client.health_card_number).to eq("1234-567-890")
    end

    it "will format phone number correctly and remove symbols if formatted with numbers only and has a length >= 10 <= 14" do
      # original input 123-456-7890
      client = Client.create! client_attributes
      expect(client.phone_number).to eq("(123) 456-7890")
    end

    it "will format emergency contact info correctly and remove symbols if formatted with numbers only and has a length >= 10 <= 14" do
      # original input 1234.4567.890
      client = Client.create! client_attributes
      expect(client.emergency_contact_info).to eq("(123) 456-7890")
    end

    it "searches a Client by name" do
      # searching from test db - therefore test db needs to be populated from basic.rb
      result = Client.search_record("Fir")
      expect(result[0].first_name).to eq("First")
    end
  end
end
