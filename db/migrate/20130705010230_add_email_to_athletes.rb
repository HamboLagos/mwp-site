class AddEmailToAthletes < ActiveRecord::Migration
  def change
    add_column :athletes, :email, :string
  end
end
