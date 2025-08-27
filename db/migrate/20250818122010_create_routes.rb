class CreateRoutes < ActiveRecord::Migration[8.0]
  def change
    create_table :routes do |t|
      t.string :start_location, null: false
      t.string :end_location, null: false

      t.timestamps
    end
  end
end
