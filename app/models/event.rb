class Event < ApplicationRecord
  belongs_to :creator, class_name: 'User', foreign_key: 'user_id'
  has_many :attendances, foreign_key: 'attended_event_id'
  has_many :attendees, through: :attendances, source: :attendee

  def self.past
    self.where('date < ?', Time.now.to_date)
  end

  def self.future
    self.where('date > ?', Time.now.to_date)
  end
end
