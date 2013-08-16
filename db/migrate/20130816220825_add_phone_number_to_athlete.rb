class AddPhoneNumberToAthlete < ActiveRecord::Migration
  def change
    add_column :athletes, :phone_number, :string
  end
end
