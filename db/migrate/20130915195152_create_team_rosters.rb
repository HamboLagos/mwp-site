class CreateTeamRosters < ActiveRecord::Migration
  def change
    create_table :team_rosters do |t|
      t.integer :athlete_id
      t.integer :season_id

      t.timestamps
    end
  end
end
