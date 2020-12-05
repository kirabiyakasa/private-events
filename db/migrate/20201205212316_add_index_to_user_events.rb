class AddIndexToUserEvents < ActiveRecord::Migration[5.2]
  def change
    add_index :user_events, [:attendee_id, :attended_event_id], unique: true
  end
end
