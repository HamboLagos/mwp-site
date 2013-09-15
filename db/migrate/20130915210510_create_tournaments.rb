class CreateTournaments < ActiveRecord::Migration
  def change
    create_table :tournaments do |t|
      t.integer :season_id
      t.string :location
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
