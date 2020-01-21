require 'rails_helper'

RSpec.describe "events/show.html.erb", type: :view do
  before do
    @user = User.create(name: 'bob')
    @event = @user.events.create(name: 'party', date: (Time.now + 3600).to_date)
    assign(:event, @event)
    render
  end

  it 'displays the name of the event' do
    expect(rendered).to match(
      Regexp.new(
        ".*#{@event.name}.*",
        1 | 4
      )
    )
  end

  it 'displays the date of the event' do
    expect(rendered).to match(
      Regexp.new(
        ".*#{@event.date}.*",
        1 | 4
      )
    )
  end

  it 'displays the creator of the event' do
    expect(rendered).to match(
      Regexp.new(
        ".*#{@event.creator.name}.*",
        1 | 4
      )
    )
  end

  context 'user logged in' do
    before do
      @jen = User.create(name: 'jen')
      controller.session[:user_id] = @jen.id
      render template: 'events/show', layout: 'layouts/application'
    end

    it 'displays the name of the logged in user at the top' do
      expect(rendered).to match(
        Regexp.new(
          ".*<header.*>.*#{@jen.name}.*</header>.*",
          1 | 4
        )
      )
    end
  end
end
