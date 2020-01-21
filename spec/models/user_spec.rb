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
end
