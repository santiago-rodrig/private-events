require 'rails_helper'

RSpec.describe Event, type: :model do
  before do
    @user = User.create(name: 'bob')
  end

  it 'belongs to a user' do
    event = Event.create(description: 'event', user_id: @user.id)
    expect(event.respond_to?(:creator)).to be_truthy
    expect(event.creator).to eq(@user)
  end

  it 'creates a new event successfully' do
    expect { Event.create(description: 'event', user_id: @user.id) }.not_to raise_error
  end

  it 'adds a new event' do
    count = Event.count
    Event.create(description: 'event', user_id: @user.id)
    expect(Event.count).to eq(count + 1)
  end

  it 'has a past method' do
    expect(Event.respond_to?(:past)).to be_truthy
  end

  describe '::past' do
    it 'returns all the past events' do
      expect(Event.past).to eq(Event.where('date < ?', Time.now.to_date))
    end
  end

  it 'has a future method' do
    expect(Event.respond_to?(:future)).to be_truthy
  end

  describe '::future' do
    it 'returns all the future events' do
      expect(Event.future).to eq(Event.where('date > ?', Time.now.to_date))
    end
  end

  it 'has many attendees' do
    event = @user.events.create(description: 'party')
    user1 = User.create(name: 'user 1')
    user2 = User.create(name: 'user 2')
    user3 = User.create(name: 'user 3')
    expect(event).to be_respond_to(:attendees)
    event.attendees << user1
    event.attendees << user2
    event.attendees << user3
    expect(event.attendees).to include(user1)
    expect(event.attendees).to include(user2)
    expect(event.attendees).to include(user3)
    expect(event.attendees.count).to eq(3)
  end

  it 'has many inviteds' do
    event = @user.events.create(description: 'party')
    user1 = User.create(name: 'user 1')
    user2 = User.create(name: 'user 2')
    user3 = User.create(name: 'user 3')
    expect(event).to be_respond_to(:inviteds)
    event.inviteds << user1
    event.inviteds << user2
    event.inviteds << user3
    expect(event.inviteds).to include(user1)
    expect(event.inviteds).to include(user2)
    expect(event.inviteds).to include(user3)
    expect(event.inviteds.count).to eq(3)
  end
end
