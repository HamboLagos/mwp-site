class CreateAthletes < ActiveRecord::Migration
  def change
    create_table :athletes do |t|
      t.string :first
      t.string :last
      t.integer :year

      t.timestamps
    end
  end
end
