require 'rails_helper'

RSpec.describe Event, type: :model do
  before do
    @user = User.create(name: 'bob')
  end

  it 'belongs to a user' do
    event = Event.create(
      name: 'event', date: (Time.now + 3600).to_date, user_id: @user.id
    )

    expect(event.respond_to?(:creator)).to be_truthy
    expect(event.creator).to eq(@user)
  end

  it 'creates a new event successfully' do
    expect do
      Event.create(
        name: 'event', date: (Time.now + 3600).to_date, user_id: @user.id
      )
    end.not_to raise_error
  end

  it 'adds a new event' do
    count = Event.count
    Event.create(
      name: 'event', date: (Time.now + 3600).to_date, user_id: @user.id
    )
    expect(Event.count).to eq(count + 1)
  end
end
