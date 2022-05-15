class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :rememberable, :validatable, :invitable

  validates :first_name, presence: true
  validates :last_name, presence: true

  ACCOUNTS = ["Admin", "Manager", "Nurse", "Doctor", "Care Worker"]
  LOCATIONS = ["Victoria General", "Royal Jubilee", "Sanich Penisula", "Nanaimo Regional"]
end
