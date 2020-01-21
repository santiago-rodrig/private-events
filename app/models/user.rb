class User < ApplicationRecord
  has_many :events
  has_many :attendances, foreign_key: 'attendee_id'
  has_many :attended_events, through: :attendances, source: :attended_event
end
