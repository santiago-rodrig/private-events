require 'rails_helper'

RSpec.describe 'users/show.html.erb', type: :view do
  before do
    @user = User.create(name: 'bob')
    assign(:user, @user)
  end

  it 'displays the name of the user' do
    assign(:attended_events, @user.attended_events)
    assign(:past_attended_events, @user.past_attended_events)
    assign(:upcoming_attended_events, @user.upcoming_attended_events)
    render
    expect(rendered).to match(
      Regexp.new(
        ".*#{@user.name}.*",
        1 | 4
      )
    )
  end

  it 'displays a list of created events' do
    @user.events.create(description: 'event 1')
    @user.events.create(description: 'event 2')
    @user.events.create(description: 'event 3')
    assign(:attended_events, @user.attended_events)
    assign(:past_attended_events, @user.past_attended_events)
    assign(:upcoming_attended_events, @user.upcoming_attended_events)
    render

    @user.events.each do |event|
      expect(rendered).to match(
        Regexp.new(
          ".*<h2>All created events</h2>.*#{event.description}.*<a.*href=\"#{event_path(event)}\".*>Show</a>.*",
          1 | 4
        )
      )
    end
  end

  it 'displays a list of attended events' do
    @stu = User.create(name: 'stuart')
    @party1 = @stu.events.create(description: 'party 1')
    @party2 = @stu.events.create(description: 'party 2')
    @party3 = @stu.events.create(description: 'party 3')
    @user.attended_events << @party1
    @user.attended_events << @party2
    @user.attended_events << @party3
    assign(:attended_events, @user.attended_events)
    assign(:past_attended_events, @user.past_attended_events)
    assign(:upcoming_attended_events, @user.upcoming_attended_events)
    render

    @user.attended_events.each do |event|
      expect(rendered).to match(
        Regexp.new(
          ".*<h2>All attended events</h2>.*#{event.description}.*<a.*href=\"#{event_path(event)}\".*>Show</a>.*",
          1 | 4
        )
      )
    end
  end

  it 'displays a list of past attended events' do
    now = Time.now
    @stu = User.create(name: 'stuart')

    @party1 = @stu.events.create(
      description: 'party 1',
      date: Date.new(now.year, now.month, now.day + 2)
    )

    @party2 = @stu.events.create(
      description: 'party 2',
      date: Date.new(now.year, now.month, now.day - 3)
    )

    @party3 = @stu.events.create(
      description: 'party 1',
      date: Date.new(now.year, now.month, now.day - 1)
    )

    assign(:attended_events, @user.attended_events)
    assign(:past_attended_events, @user.past_attended_events)
    assign(:upcoming_attended_events, @user.upcoming_attended_events)
    render

    @user.past_attended_events.each do |event|
      expect(rendered).to match(
        Regexp.new(
          ".*<h2>Past attended events</h2>.*#{event.description}.*<a.*href=\"#{event_path(event)}\".*>Show</a>.*",
          1 | 4
        )
      )
    end
  end

  it 'displays a list of upcoming attended events' do
    now = Time.now
    @stu = User.create(name: 'stuart')

    @party1 = @stu.events.create(
      description: 'party 1',
      date: Date.new(now.year, now.month, now.day - 2)
    )

    @party2 = @stu.events.create(
      description: 'party 2',
      date: Date.new(now.year, now.month, now.day + 3)
    )

    @party3 = @stu.events.create(
      description: 'party 1',
      date: Date.new(now.year, now.month, now.day + 1)
    )

    @user.attended_events << @party1
    @user.attended_events << @party2
    @user.attended_events << @party3
    assign(:attended_events, @user.attended_events)
    assign(:past_attended_events, @user.past_attended_events)
    assign(:upcoming_attended_events, @user.upcoming_attended_events)
    render

    @user.upcoming_attended_events.each do |event|
      expect(rendered).to match(
        Regexp.new(
          ".*<h2>Upcoming events to attend</h2>.*#{event.description}.*<a.*href=\"#{event_path(event)}\".*>Show</a>.*",
          1 | 4
        )
      )
    end
  end
end
