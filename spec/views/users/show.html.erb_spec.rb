require 'rails_helper'

RSpec.describe "users/show.html.erb", type: :view do
  before do
    @user = User.create(name: 'bob')
    assign(:user, @user)
    render
  end

  it 'displays the name of the user' do
    expect(rendered).to match(
      Regexp.new(
        ".*#{@user.name}.*",
        1 | 4
      )
    )
  end

  it 'displays a list of created events' do
    @user = User.create(name: 'bob')
    @user.events.create(description: 'event 1')
    @user.events.create(description: 'event 2')
    @user.events.create(description: 'event 3')
    assign(:user, @user)
    render

    @user.events.each do |event|
      expect(rendered).to match(
        Regexp.new(
          ".*#{event.description}.*",
          1 | 4
        )
      )
    end
  end

  it 'displays a list of attended events' do
    @user = User.create(name: 'bob')
    @stu = User.create(name: 'stuart')
    @party_1 = @stu.events.create(description: 'party 1')
    @party_2 = @stu.events.create(description: 'party 2')
    @party_3 = @stu.events.create(description: 'party 3')
    @user.attended_events << @party_1
    @user.attended_events << @party_2
    @user.attended_events << @party_3
    assign(:user, @user)
    render

    @user.attended_events.each do |event|
      expect(rendered).to match(
        Regexp.new(
          ".*#{event.description}.*",
          1 | 4
        )
      )
    end
  end

  it 'displays a list of past attended events' do
    now = Time.now
    @user = User.create(name: 'bob')
    @stu = User.create(name: 'stuart')

    @party_1 = @stu.events.create(
      description: 'party 1',
      date: Date.new(now.year, now.month, now.day + 2)
    )

    @party_2 = @stu.events.create(
      description: 'party 2',
      date: Date.new(now.year, now.month, now.day - 3)
    )

    @party_1 = @stu.events.create(
      description: 'party 1',
      date: Date.new(now.year, now.month, now.day - 1)
    )

    @user.attended_events << @party_1
    @user.attended_events << @party_2
    @user.attended_events << @party_3
    assign(:user, @user)
    assign(:attended_events, @user.attended_events)
    assign(:past_attended_events, @user.past_attended_events)
    assign(:upcoming_attended_events, @user.upcoming_attended_events)
    render

    @user.past_attended_events.each do |event|
      expect(rendered).to match(
        Regexp.new(
          ".*#{event.description}.*",
          1 | 4
        )
      )
    end
  end

  it 'displays a list of upcoming attended events' do
    now = Time.now
    @user = User.create(name: 'bob')
    @stu = User.create(name: 'stuart')

    @party_1 = @stu.events.create(
      description: 'party 1',
      date: Date.new(now.year, now.month, now.day - 2)
    )

    @party_2 = @stu.events.create(
      description: 'party 2',
      date: Date.new(now.year, now.month, now.day + 3)
    )

    @party_1 = @stu.events.create(
      description: 'party 1',
      date: Date.new(now.year, now.month, now.day + 1)
    )

    @user.attended_events << @party_1
    @user.attended_events << @party_2
    @user.attended_events << @party_3
    assign(:user, @user)
    assign(:attended_events, @user.attended_events)
    assign(:past_attended_events, @user.past_attended_events)
    assign(:upcoming_attended_events, @user.upcoming_attended_events)
    render

    @user.upcoming_attended_events.each do |event|
      expect(rendered).to match(
        Regexp.new(
          ".*#{event.description}.*",
          1 | 4
        )
      )
    end
  end

  context 'the user is signed in' do
    before do
      @user = User.create(name: 'bob')
      controller.session[:user_id] = @user.id
      assign(:user, @user)
      render template: 'users/new', layout: 'layouts/application'
    end

    it 'displays the name of the user at the top' do
      expect(rendered).to match(
        Regexp.new(
          ".*<header.*>.*#{@user.name}.*</header>.*",
          1 | 4
        )
      )
    end
  end
end
