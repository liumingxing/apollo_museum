class CreateMuseumTrips < ActiveRecord::Migration[5.2]
  def change
    create_table :museums_trips do |t|
      t.integer :trip_id
      t.integer :museum_id
      t.timestamps
    end
    add_index :museums_trips, [:trip_id, :museum_id], name: :trip_museum, unique: true
  end
end
