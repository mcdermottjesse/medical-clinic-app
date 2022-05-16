class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :recoverable, :rememberable, :validatable

  validates :first_name, presence: true
  validates :last_name, presence: true

  # validates_format_of :password, with: /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,16}]]$\z/

  ACCOUNTS = ["Admin", "Manager", "Nurse", "Doctor", "Care Worker"]
  LOCATIONS = ["Victoria General", "Royal Jubilee", "Sanich Penisula", "Nanaimo Regional"]
end
