require 'rails_helper'

RSpec.describe 'events/index.html.erb', type: :view do
  before do
    now = Time.now
    @jen = User.create(name: 'jen')

    @jen.events.create([
      { description: 'party', date: Date.new(now.year, now.month, now.day + 1) },
      { description: 'beach party', date: Date.new(now.year, now.month, now.day - 1) },
      { description: 'birthday party', date: Date.new(now.year, now.month, now.day + 5) }
    ])

    @events = Event.all
    @past_events = Event.past
    @future_events = Event.future
    assign(:events, @events)
    assign(:past_events, @past_events)
    assign(:future_events, @future_events)
    render
  end

  it 'displays all the event' do
    @events.each do |event|
      expect(rendered).to match(
        Regexp.new(
          ".*<h2>All events</h2>.*#{event.description}.*<a.*href=\"#{event_path(event)}\".*>Show</a>.*",
          1 | 4
        )
      )
    end
  end

  it 'displays a list of past events' do
    @past_events.each do |event|
      expect(rendered).to match(
        Regexp.new(
          ".*<h2>Past events</h2>.*#{event.description}.*<a.*href=\"#{event_path(event)}\".*>Show</a>.*",
          1 | 4
        )
      )
    end
  end

  it 'displays a list of future events' do
    @future_events.each do |event|
      expect(rendered).to match(
        Regexp.new(
          ".*<h2>Future events</h2>.*#{event.description}.*<a.*href=\"#{event_path(event)}\".*>Show</a>.*",
          1 | 4
        )
      )
    end
  end
end
