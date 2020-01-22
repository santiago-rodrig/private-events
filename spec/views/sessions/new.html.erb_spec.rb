require 'rails_helper'

RSpec.describe 'sessions/new.html.erb', type: :view do
  before do
    render
  end

  it 'displays a form pointing to /login' do
    expect(rendered).to match(
      Regexp.new(
        '.*<form.*action="/login".*</form>.*',
        1 | 4
      )
    )
  end

  it 'displays a text input inside a form' do
    expect(rendered).to match(
      Regexp.new(
        '.*<form.*>.*<input.*type="text".*>.*</form>.*',
        1 | 4
      )
    )
  end
end
