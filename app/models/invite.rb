class Invite < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :recipient, class_name: 'User'

  belongs_to :events, class_name: 'Event', foreign_key: :event_id

  validates :sender_id, presence: true
  validates :recipient_id, presence: true
  validates :event_id, presence: true
  validates :recipient_id, uniqueness: { scope: :event_id }
end
