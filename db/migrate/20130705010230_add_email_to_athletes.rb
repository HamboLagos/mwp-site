class AddEmailToAthletes < ActiveRecord::Migration
  def change
    add_column :athletes, :email, :string, unique: true
  end
end
