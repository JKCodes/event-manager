class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :name
      t.datetime :start_time
      t.datetime :end_time
      t.integer :user_id
      t.integer :location_id

      t.timestamps
    end
  end
end
