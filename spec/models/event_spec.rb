require 'rails_helper'

RSpec.describe Event, type: :model do
  it 'creates a new event successfully' do
    expect do
      Event.create(name: 'event', date: (Time.now + 3600).to_date)
    end.not_to raise_error
  end
end
