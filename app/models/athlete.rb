class Athlete < ActiveRecord::Base
  has_secure_password

  has_many :posts

  validates :first, presence: true
  validates :last, presence: true
  validates :year, presence: true
  validates :email, presence: true

  def name
    "#{self.first} #{self.last}"
  end

  # other is space deflimited, first and last name string
  def name= other
    self.first = other.split.first
    self.last = other.split.last
  end

  def name? other
    name == other
  end
end
