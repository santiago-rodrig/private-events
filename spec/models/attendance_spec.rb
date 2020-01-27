require 'rails_helper'

RSpec.describe Attendance, type: :model do
  before do
    @user = User.create(name: 'bob')
    @event = @user.events.create(description: 'hugue party')
    @attendance = Attendance.create(attendee_id: @user.id, attended_event_id: @event.id)
  end

  it 'belongs to a an attendee' do
    expect(@attendance).to be_respond_to(:attendee)
    expect(@attendance.attendee).to eq(@user)
  end

  it 'belongs to an attended_event' do
    expect(@attendance).to be_respond_to(:attended_event)
    expect(@attendance.attended_event).to eq(@event)
  end
end
