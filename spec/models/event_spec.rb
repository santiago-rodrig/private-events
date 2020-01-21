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
end
