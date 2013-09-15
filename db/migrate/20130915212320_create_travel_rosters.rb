class CreateTravelRosters < ActiveRecord::Migration
  def change
    create_table :travel_rosters do |t|
      t.integer :athlete_id
      t.integer :tournament_id

      t.timestamps
    end
  end
end
