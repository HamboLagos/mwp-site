class Season < ActiveRecord::Base

  validates :year, uniqueness: true

end
