class TravelRoster < ActiveRecord::Base
  belongs_to :athlete
  belongs_to :tournament
end
