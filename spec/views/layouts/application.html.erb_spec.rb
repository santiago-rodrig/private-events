require 'rails_helper'

RSpec.describe 'layouts/application.html.erb', type: :view do
  it 'displays a link for listing events' do
    render html: '', layout: 'layouts/application'
    expect(rendered).to match(
      Regexp.new(
        ".*<header.*>.*<a.*href=\"#{events_path}\".*>Events</a>.*",
        1 | 4
      )
    )
  end

  context 'user logged in' do
    before do
      @user = User.create(name: 'bob')
      controller.session[:user_id] = @user.id
      render html: '', layout: 'layouts/application'
    end

    it 'displays the name of the logged user at the top' do
      expect(rendered).to match(
        Regexp.new(
          ".*<header.*>.*#{@user.name}.*</header>.*",
          1 | 4
        )
      )
    end

    it 'displays a link for creating events' do
      expect(rendered).to match(
        Regexp.new(
          ".*<header.*>.*<a.*href=\"#{new_event_path}\".*>Create event</a>.*",
          1 | 4
        )
      )
    end

    it 'displays a link for showing the profile of the current user' do
      expect(rendered).to match(
        Regexp.new(
          ".*<header.*>.*<a.*href=\"#{user_path(@user)}\".*>Profile</a>.*",
          1 | 4
        )
      )
    end

    it 'displays a link for logging out' do
      expect(rendered).to match(
        Regexp.new(
          ".*<header.*>.*<a.*href=\"#{logout_path}\".*>Logout</a>.*",
          1 | 4
        )
      )
    end
  end

  context 'user not logged in' do
    before do
      @user = User.create(name: 'bob')
      controller.session.delete(:user_id)
      render html: '', layout: 'layouts/application'
    end

    it 'does not display the name of the user at the top' do
      expect(rendered).not_to match(
        Regexp.new(
          ".*<header.*>.*#{@user.name}.*</header>.*",
          1 | 4
        )
      )
    end

    it 'displays a link to sign up' do
      expect(rendered).to match(
        Regexp.new(
          ".*<header.*>.*<a.*href=\"#{new_user_path}\".*>Sign up</a>.*",
          1 | 4
        )
      )
    end

    it 'displays a link to login' do
      expect(rendered).to match(
        Regexp.new(
          ".*<header.*>.*<a.*href=\"#{login_path}\".*>Login</a>.*",
          1 | 4
        )
      )
    end
  end
end
