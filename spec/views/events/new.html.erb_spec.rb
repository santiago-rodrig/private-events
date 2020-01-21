require 'rails_helper'

RSpec.describe 'events/new.html.erb', type: :view do
  before do
    @event = Event.new
    assign(:user, @user)
    render
  end

  it 'displays a form linking to events' do
    expect(rendered).to match(
      Regexp.new(
        '.*<form.*action="/events".*>.*</form>.*',
        1 | 4
      )
    )
  end

  it 'displays a text input field for the event name' do
    expect(rendered).to match(
      Regexp.new(
        '.*<form.*>.*<input.*type="text".*>.*</form>.*',
        1 | 4
      )
    )
  end

  it 'displays a date field for the event date' do
    expect(rendered).to match(
      Regexp.new(
        '.*<form.*>.*<input.*type="date".*>.*</form>.*',
        1 | 4
      )
    )
  end

  it 'displays a submit button' do
    expect(rendered).to match(
      Regexp.new(
        '.*<form.*>.*<input.*type="submit".*>.*</form>.*',
        1 | 4
      )
    )
  end
end
