class Athlete < ActiveRecord::Base
  has_secure_password

  has_many :posts

  before_validation { self.email.downcase! }
  before_save { :create_remember_token }

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true


  def name
    "#{first_name} #{last_name}"
  end

  # other is space deflimited string containing first and last names
  # yes: "Samuel Jackson", "Omar Rodriguez-Lopez"
  # no: "Booker T. Washington" => "Booker Washington"
  def name= other
    self.first_name = other.split.first
    self.last_name = other.split.last
  end

  def name? other
    name == other
  end

  private

  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end
end
