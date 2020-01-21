require 'rails_helper'

RSpec.describe 'events/index.html.erb', type: :view do
  before do
    @jen = User.create(name: 'jen')

    @jen.events.create([
      { name: 'party', date: (Time.now + 3600).to_date },
      { name: 'beach party', date: (Time.now + 7200).to_date },
      { name: 'birthday party', date: (Time.now + 10800).to_date }
    ])

    @events = Event.all
    assign(:events, @events)
    render
  end

  it 'displays all the event names' do
    @events.each do |event|
      expect(rendered).to match(
        Regexp.new(
          ".*#{event.name}.*",
          1 | 4
        )
      )
    end
  end

  context 'user logged in' do
    before do
      @user = User.create(name: 'bob')
      controller.session[:user_id] = @user.id
      render template: 'events/index', layout: 'layouts/application'
    end

    it 'displays the name of the logged user at the top' do
      expect(rendered).to match(
        Regexp.new(
          ".*<header.*>.*#{@user.name}.*</header>.*",
          1 | 4
        )
      )
    end
  end
end
