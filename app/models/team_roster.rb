class TeamRoster < ActiveRecord::Base
  belongs_to :athlete
  belongs_to :season

  validates :season, presence: true
  # no need to validate athlete, because athletes must have a season
  # which automatically means athlete_id will be present
end
