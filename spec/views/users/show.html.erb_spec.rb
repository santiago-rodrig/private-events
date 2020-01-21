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
