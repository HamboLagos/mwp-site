class Season < ActiveRecord::Base
  has_many :team_rosters
  has_many :athletes, through: :team_rosters
  has_many :tournaments

  validates :year, uniqueness: true

end
