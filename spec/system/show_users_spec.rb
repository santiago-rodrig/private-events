require 'rails_helper'

RSpec.describe 'ShowUsers', type: :system do
  before do
    driven_by(:selenium_chrome)
    @user = User.create(name: 'bob')
  end

  it 'shows a user profile' do
    visit(user_path(@user))
    expect(page).to have_current_path(user_path(@user))
    expect(page).to have_content(@user.name)
    expect(page).not_to have_content('Invitations')
    expect(page).to have_content('All attended events')
    expect(page).to have_content('Past attended events')
    expect(page).to have_content('Upcoming events to attend')
  end

  it 'shows invitations if is the same user' do
    visit('/login')
    fill_in('Name', with: 'bob')
    find('input[type="submit"]').click
    visit(user_path(@user))
    expect(page).to have_current_path(user_path(@user))
    expect(page).to have_content(@user.name)
    expect(page).to have_content('Invitations')
    expect(page).to have_content('All attended events')
    expect(page).to have_content('Past attended events')
    expect(page).to have_content('Upcoming events to attend')
  end
end
