require 'rails_helper'

RSpec.describe User, type: :model do
  it 'creates a user' do
    expect { User.create(name: 'bob') }.not_to raise_error
  end

  it 'add a new user' do
    count = User.count
    User.create(name: 'jen')
    expect(User.count).to eq(count + 1)
  end

  it 'has many events' do
    user = User.create(name: 'jen')

    event = Event.create(
      description: 'party', user_id: user.id
    )

    expect(user.respond_to?(:events)).to be_truthy
    expect(user.events).to include(event)
  end
end
