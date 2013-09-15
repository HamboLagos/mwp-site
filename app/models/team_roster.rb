class TeamRoster < ActiveRecord::Base
  belongs_to :athlete
  belongs_to :season
end
