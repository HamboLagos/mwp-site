class AddDriverAndCarToTravelRoster < ActiveRecord::Migration
  def change
    add_column :travel_rosters, :driver, :boolean
    add_column :travel_rosters, :car, :integer
  end
end
