class CreateInvites < ActiveRecord::Migration[5.2]
  def change
    create_table :invites do |t|
      t.string :username

      t.integer :sender_id
      t.integer :recipient_id
      t.integer :event_id

      t.timestamps
    end
  end
end
