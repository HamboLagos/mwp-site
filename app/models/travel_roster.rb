class TravelRoster < ActiveRecord::Base
  belongs_to :athlete
  belongs_to :tournament

  validates :athlete, presence: true
  # dont check for tournament, it invalidates creating a new tournament with athletes
  # validates :tournament, presence: true
end
