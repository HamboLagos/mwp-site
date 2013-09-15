class AddUniqueOnSeasonYear < ActiveRecord::Migration
  def change
    add_index :seasons, :year, unique: true
  end
end
