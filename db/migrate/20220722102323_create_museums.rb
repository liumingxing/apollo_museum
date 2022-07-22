class CreateMuseums < ActiveRecord::Migration[5.2]
  def change
    create_table :museums do |t|
      t.string :name
      t.string :state
      t.string :city
      t.text   :description
      t.timestamps
    end
    add_index :museums, :name, unique: true
    add_index :museums, [:state, :city], name: :state_city
  end
end
