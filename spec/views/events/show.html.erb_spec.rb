require 'rails_helper'

RSpec.describe 'events/show.html.erb', type: :view do
  before do
    @user = User.create(name: 'bob')
    @stu = User.create(name: 'stu')
    @jen = User.create(name: 'jen')
    @event = @user.events.create(description: 'party')
    @event.attendees << @stu
    @event.attendees << @jen
    @attendees = @event.attendees
    assign(:event, @event)
    assign(:attendees, @attendees)
    render
  end

  it 'displays the description of the event' do
    expect(rendered).to match(
      Regexp.new(
        ".*<h2>Description</h2>.*#{@event.description}.*",
        1 | 4
      )
    )
  end

  it 'displays the date of the event' do
    expect(rendered).to match(
      Regexp.new(
        ".*<h2>Date</h2>.*#{@event.date}.*",
        1 | 4
      )
    )
  end

  it 'displays the creator of the event' do
    expect(rendered).to match(
      Regexp.new(
        ".*<h2>Creator</h2>.*#{@event.creator.name}.*<a.*href=\"#{user_path(@event.creator)}\".*>Show</a>.*",
        1 | 4
      )
    )
  end

  it 'displays a list of attendees' do
    @attendees.each do |attendee|
      expect(rendered).to match(
        Regexp.new(
          ".*<h2>Attendees</h2>.*#{attendee.name}.*<a.*href=\"#{user_path(attendee)}\".*>Show</a>.*",
          1 | 4
        )
      )
    end
  end
end
