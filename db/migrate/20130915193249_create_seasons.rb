class CreateSeasons < ActiveRecord::Migration
  def change
    create_table :seasons do |t|
      t.integer :year, unique: true

      t.timestamps
    end
  end
end
