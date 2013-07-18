class AddRememberTokenToAthlete < ActiveRecord::Migration
  def change
    add_column :athletes, :remember_token, :string
  end
end
