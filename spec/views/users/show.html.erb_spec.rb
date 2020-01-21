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
end
