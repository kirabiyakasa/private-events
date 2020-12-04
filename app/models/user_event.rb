class UserEvent < ApplicationRecord
  belongs_to :attended_event, class_name: :event
  belongs_to :attendee, class_name: :user
end
