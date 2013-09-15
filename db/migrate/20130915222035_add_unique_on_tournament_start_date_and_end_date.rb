class AddUniqueOnTournamentStartDateAndEndDate < ActiveRecord::Migration
  def change
    add_index :tournaments, [:start_date, :end_date], unique: true
  end
end
