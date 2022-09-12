class User < ApplicationRecord

  has_many :client_logs

  attr_accessor :skip_password_validation
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :recoverable, :rememberable, :validatable

  validates :first_name, :last_name, :account_type, :location, presence: true

  validates :password, format: { with: /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,16}\z/, message: :validation_message }, unless: :skip_password_validation

  before_save :capitalize_name
  
  class << self
    include Search
  end

  include Name, Location

  ACCOUNT_TYPES = ['Admin', 'Manager', 'Nurse', 'Doctor', 'Care Worker']

  def admin?
    account_type == 'Admin'
  end

  def manager?
    account_type == 'Manager'
  end

  def doctor?
    account_type == 'Doctor'
  end

  def nurse?
    account_type == 'Nurse'
  end

  def care_worker?
    account_type == 'Care Worker'
  end
end
