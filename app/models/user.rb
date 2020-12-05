class User < ApplicationRecord
  has_many :user_events, foreign_key: :attendee_id
  has_many :attended_events, through: :user_events
  has_many :created_events, class_name: 'Event', foreign_key: :creator_id

  validates :username, presence: true
end
