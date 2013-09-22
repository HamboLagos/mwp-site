class Tournament < ActiveRecord::Base
  belongs_to :season
  has_many :travel_rosters
  has_many :athletes, through: :travel_rosters

  validates :season, presence: true
  validates :location, presence: true
  validates :start_date, presence: true, uniqueness: true
  validates :end_date, presence: true, uniqueness: true

  accepts_nested_attributes_for :travel_rosters

  def self.current_season_tournaments
    Season.current_season.tournaments
  end
end
