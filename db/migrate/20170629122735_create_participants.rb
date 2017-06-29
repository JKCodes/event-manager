class CreateParticipants < ActiveRecord::Migration[5.1]
  def change
    create_table :participants do |t|
      t.string :nickname
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone_number
      t.integer :user_id

      t.timestamps
    end
  end
end
