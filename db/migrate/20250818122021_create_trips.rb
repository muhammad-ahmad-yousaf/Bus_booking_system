class CreateTrips < ActiveRecord::Migration[8.0]
  def change
    create_table :trips do |t|
      t.references :bus, null: false, foreign_key: true
      t.references :route, null: false, foreign_key: true
      t.datetime :departure_time, null: false
      t.datetime :arrival_time, null: false
      t.integer :avail_seats
      t.decimal :fare

      t.timestamps
    end
  end
end
