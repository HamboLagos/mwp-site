class Athlete < ActiveRecord::Base
  has_many :posts

  validates :first, presence: true
  validates :last, presence: true
  validates :year, presence: true
  validates :email, presence: true
end
