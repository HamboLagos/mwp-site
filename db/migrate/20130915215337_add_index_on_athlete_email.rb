class AddIndexOnAthleteEmail < ActiveRecord::Migration
  def change
    add_index :athletes, :email, unique: true
  end
end
