class CreateBookings < ActiveRecord::Migration[8.0]
  def change
    create_table :bookings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :trip, null: false, foreign_key: true
      t.integer :seat_number
      t.integer :status, default: 0, null: false

      t.timestamps
    end
  end
end
