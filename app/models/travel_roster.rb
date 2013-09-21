class TravelRoster < ActiveRecord::Base
  belongs_to :athlete
  belongs_to :tournament

  validates :athlete, presence: true
  # dont check for tournament, it invalidates creating a new tournament with athletes
  # because travelroster is created before tournament is saved, therefore it has no tournament_id
  # validates :tournament, presence: true

  def car_name
    Athlete.find_by(id: self.car).name
  end

  def name
    Athlete.find(self.athlete_id).name
  end
end
