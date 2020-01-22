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

  it 'displays a text area field for the event description' do
    expect(rendered).to match(
      Regexp.new(
        '.*<form.*>.*<textarea.*>.*</textarea>.*</form>.*',
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
