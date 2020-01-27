class Event < ApplicationRecord
  belongs_to :creator, class_name: 'User', foreign_key: 'user_id'
  has_many :attendances, foreign_key: 'attended_event_id'
  has_many :attendees, through: :attendances, source: :attendee
  has_many :invitations, foreign_key: 'inviting_event_id'
  has_many :inviteds, through: :invitations, source: :invited
  scope :past, -> { where('date < ?', Time.now.to_date) }
  scope :future, -> { where('date > ?', Time.now.to_date) }
end
