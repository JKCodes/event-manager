class CreateEventParticipants < ActiveRecord::Migration[5.1]
  def change
    create_table :event_participants do |t|
      t.integer :event_id
      t.integer :participant_id

      t.timestamps
    end
  end
end
