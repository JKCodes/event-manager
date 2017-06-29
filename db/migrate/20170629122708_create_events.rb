class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :name
      t.datetime :start_datetime
      t.integer :duration
      t.integer :user_id
      t.integer :location_id

      t.timestamps
    end
  end
end
