require 'rails_helper'

RSpec.describe User, type: :model do
  it 'creates a user' do
    expect { User.create(name: 'bob') }.not_to raise_error
  end

  before do
    @user = User.create(name: 'jen')
    @event = Event.create(
      description: 'party', user_id: @user.id
    )
  end

  it 'add a new user' do
    count = User.count
    User.create(name: 'stuart')
    expect(User.count).to eq(count + 1)
  end

  it 'has many events' do
    expect(@user.respond_to?(:events)).to be_truthy
    expect(@user.events).to include(@event)
  end

  it 'has many attended_events' do
    expect(@user).to be_respond_to(:attended_events)
    user = User.create(name: 'crystal')
    event = user.events.create(description: 'small meeting')
    @user.attended_events << event
    expect(@user.attended_events).to include(event)
  end

  it 'has past_attended_events' do
    now = Time.now.to_date
    user = User.create(name: 'crystal')

    event_1 = user.events.create(
      description: 'small meeting',
      date: Date.new(now.year, now.month, now.day - 2)
    )

    event_2 = user.events.create(
      description: 'family meeting',
      date: Date.new(now.year, now.month, now.day - 6)
    )

    event_3 = user.events.create(
      description: 'soccer game',
      date: Date.new(now.year, now.month, now.day + 1)
    )

    events = [event_1, event_2, event_3]
    events.each { |e| @user.attended_events << e }
    old_events = @user.attended_events.where('date < ?', Time.now.to_date)
    expect(@user.respond_to?(:past_attended_events)).to be_truthy
    expect(@user.past_attended_events).to eq(old_events)
    expect(@user.past_attended_events.count).to eq(2)
  end

  it 'has upcoming_attended_events' do
    now = Time.now.to_date
    user = User.create(name: 'crystal')

    event_1 = user.events.create(
      description: 'small meeting',
      date: Date.new(now.year, now.month, now.day + 2)
    )

    event_2 = user.events.create(
      description: 'family meeting',
      date: Date.new(now.year, now.month, now.day + 6)
    )

    event_3 = user.events.create(
      description: 'soccer game',
      date: Date.new(now.year, now.month, now.day - 1)
    )

    events = [event_1, event_2, event_3]
    events.each { |e| @user.attended_events << e }
    upcoming_events = @user.attended_events.where('date >= ?', Time.now.to_date)
    expect(@user.respond_to?(:past_attended_events)).to be_truthy
    expect(@user.upcoming_attended_events).to eq(upcoming_events)
    expect(@user.upcoming_attended_events.count).to eq(2)
  end
end
