class Event < ApplicationRecord
  belongs_to :creator, class_name: 'User', foreign_key: 'user_id'
  has_many :attendances, foreign_key: 'attended_event_id'
  has_many :attendees, through: :attendances, source: :attendee
end
