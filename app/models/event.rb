class Event < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  has_many :attendees, through: :user_events

  validates :date, presence: true
end
