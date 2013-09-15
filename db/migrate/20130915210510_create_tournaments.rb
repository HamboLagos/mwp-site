class CreateTournaments < ActiveRecord::Migration
  def change
    create_table :tournaments do |t|
      t.integer :season_id
      t.string :location
      t.date :start_date, unique: true
      t.date :end_date, unique: true

      t.timestamps
    end
  end
end
