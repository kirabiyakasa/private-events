class CreateUserEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :users_events, :id => false do |t|
      t.integer :attended_event_id
      t.integer :attendee_id

      t.timestamps
    end
  end
end
