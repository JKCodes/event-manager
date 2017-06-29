class CreateEventParticipants < ActiveRecord::Migration[5.1]
  def change
    create_table :event_participants do |t|

      t.timestamps
    end
  end
end
