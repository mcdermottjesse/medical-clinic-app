class User < ApplicationRecord
  attr_accessor :skip_password_validation
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :recoverable, :rememberable, :validatable

  validates :first_name, presence: true
  validates :last_name, presence: true

  validates :password, format: { with: /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,16}\z/, message: :validation_message }, unless: :skip_password_validation

  ACCOUNTS = ["Admin", "Manager", "Nurse", "Doctor", "Care Worker"]
  LOCATIONS = ["Victoria General", "Royal Jubilee", "Sanich Penisula", "Nanaimo Regional"]

  def full_name
    [first_name, last_name].join(" ")
  end
end
