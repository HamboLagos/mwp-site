class Season < ActiveRecord::Base
  has_many :team_rosters
  has_many :athletes, through: :team_rosters
  has_many :tournaments

  validates :year, uniqueness: true

  # newest created season should be current by default
  before_create(on: :create) do |season|
    Season.all.each do |s|
      s.update!(current: false)
    end
    season.current = true
  end

  def year_as_string
    self.year.to_s
  end

  def set_as_current_season
    Season.all.each do |s|
      s.update!(current: false)
    end
    self.update!(current: true)
  end

  def self.current_season
    @current_season ||= Season.find_by(current: true)
  end

end
