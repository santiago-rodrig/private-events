require 'rails_helper'

RSpec.describe "AttendEvents", type: :system do
  before do
    driven_by(:selenium_chrome)
    @user = User.create(name: 'bob')
    @event = @user.events.create(description: 'party')
    @jen = User.create(name: 'jen')
    @stu = User.create(name: 'stu')
  end

  it 'attends an event' do
    visit(login_path)
    fill_in('Name', with: 'bob')
    find('input[type="submit"]').click
    find("a[href=\"#{event_path(@event)}\"]").click
    find('input[type="text"]').set('jen, stu')
    click_on('Invite')
    click_on('Logout')
    click_on('Login')
    fill_in('Name', with: 'jen')
    find('input[type="submit"]').click
    click_on('Profile')
    find("a[href=\"#{attend_user_path(id: @jen.id, event_id: @event.id)}\"]").click
    expect(page).to have_current_path(user_path(@jen))

    expect(page.html).to match(
      /.*<h2>All attended events<\/h2>.*#{@event.description}.*<h2>Past attended events<\/h2>.*/mi
    )

    click_on('Logout')
    click_on('Login')
    fill_in('Name', with: 'stu')
    find('input[type="submit"]').click
    click_on('Profile')
    find("a[href=\"#{attend_user_path(id: @stu.id, event_id: @event.id)}\"]").click
    expect(page).to have_current_path(user_path(@stu))

    expect(page.html).to match(
      /.*<h2>All attended events<\/h2>.*#{@event.description}.*<h2>Past attended events<\/h2>.*/mi
    )
  end
end
