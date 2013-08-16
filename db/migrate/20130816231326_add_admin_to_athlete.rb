class AddAdminToAthlete < ActiveRecord::Migration
  def change
    add_column :athletes, :admin, :bool, default: false
  end
end
