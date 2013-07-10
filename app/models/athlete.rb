class Athlete < ActiveRecord::Base
  has_secure_password

  has_many :posts

  before_validation { self.email.downcase! }

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true


  def name
    "#{self.first_name} #{self.last_name}"
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
end
