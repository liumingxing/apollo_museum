class CreateTrips < ActiveRecord::Migration[5.2]
  def change
    create_table :trips do |t|
      t.integer :user_id
      t.string  :name
      t.date    :trip_day
      t.string  :tp
      t.timestamps
    end
    add_index :trips, :user_id
  end
end
