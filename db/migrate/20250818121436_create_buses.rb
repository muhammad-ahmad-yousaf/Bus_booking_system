class CreateBuses < ActiveRecord::Migration[8.0]
  def change
    create_table :buses do |t|
      t.string :bus_num
      t.integer :capacity
      t.string :bus_type

      t.timestamps
    end
  end
end
