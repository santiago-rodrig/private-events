require 'rails_helper'

RSpec.describe "InviteUsers", type: :system do
  before do
    driven_by(:selenium_chrome)
    @user = User.create(name: 'bob')
    @event = @user.events.create(description: 'party')
    @jen = User.create(name: 'jen')
    @stu = User.create(name: 'stu')
  end

  it 'invites a list of users' do
    visit(login_path)
    fill_in('Name', with: 'bob')
    find('input[type="submit"]').click
    expect(page).to have_current_path(root_path)
    find("a[href=\"#{event_path(@event)}\"]").click
    expect(page).to have_selector('form')
    expect(page).to have_selector('form input[type="text"]')
    expect(page).to have_selector('form input[type="submit"]')
    expect(page).to have_content('Users to invite')
    find('input#invitation_users').set('jen, stu')
    click_on('Invite')
    expect(page).to have_current_path(event_path(@event))
    click_on('Logout')
    click_on('Login')
    fill_in('Name', with: 'jen')
    find('input[type="submit"]').click
    click_on('Profile')
    expect(page).to have_content('Invitations')
    expect(page).to have_content(@event.description)
    click_on('Logout')
    click_on('Login')
    fill_in('Name', with: 'stu')
    find('input[type="submit"]').click
    click_on('Profile')
    expect(page).to have_content('Invitations')
    expect(page).to have_content(@event.description)
  end
end
