class AddYearInSchoolToAthlete < ActiveRecord::Migration
  def change
    add_column :athletes, :year_in_school, :string
  end
end
