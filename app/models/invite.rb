class Invite < ApplicationRecord

  belongs_to :sender, class_name: 'User'
  belongs_to :recipient, class_name: 'User'

  belongs_to :events, class_name: 'Event', foreign_key: :event_id

  validates :sender_id, presence: true
  validates :recipient_id, presence: true
  validates :event_id, presence: true
  validates_uniqueness_of :username, :scope => [:event_id],
  message: "does not exist or you have already sent an invite."
end
