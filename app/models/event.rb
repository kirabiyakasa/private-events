class Event < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  has_many :user_events, foreign_key: :attended_event_id
  has_many :attendees, through: :user_events

  has_many :invites
  validates_associated :invites

  validates :date, presence: true
  validates :description, presence: true

  scope :upcoming_events, -> { where("date > ?", Date.today) }
  scope :previous_events, -> { where("date < ?", Date.today) }
end
