require 'rails_helper'

RSpec.describe "users/new.html.erb", type: :view do
  before do
    assign(:user, User.new)
  end

  it 'renders a form with the right action' do
    render
    expect(rendered).to match(
      Regexp.new(
        '.*<form.*action="/users".*',
        1 | 4
      )
    )
  end

  it 'renders a text input inside the form' do
    render
    expect(rendered).to match(
      Regexp.new(
        '.*<form.*>.*<input.*type="text".*',
        1 | 4
      )
    )
  end

  it 'renders a submit button inside the form' do
    render
    expect(rendered).to match(
      Regexp.new(
        '.*<form.*>.*<input.*type="submit".*',
        1 | 4
      )
    )
  end
end
