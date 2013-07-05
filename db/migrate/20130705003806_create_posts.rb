class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :athlete_id
      t.string :title
      t.text :content

      t.timestamps
    end
    add_index :posts, :athlete_id
  end
end
