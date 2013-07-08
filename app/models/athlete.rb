class Athlete < ActiveRecord::Base
  has_secure_password

  has_many :posts

  validates :first, presence: true
  validates :last, presence: true
  validates :email, presence: true
  # validates :year, presence: true

  def name
    "#{self.first} #{self.last}"
  end

  # other is space deflimited string containing first and last names
  # yes: "Samuel Jackson", "Omar Rodriguez-Lopez"
  # no: "Booker T. Washington" => "Booker Washington"
  def name= other
    self.first = other.split.first
    self.last = other.split.last
  end

  def name? other
    name == other
  end
end
