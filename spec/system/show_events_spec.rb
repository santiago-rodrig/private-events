require 'rails_helper'

RSpec.describe "ShowEvents", type: :system do
  before do
    driven_by(:selenium_chrome)
    @user = User.create(name: 'bob')
    @jen = User.create(name: 'jen')
    @stu = User.create(name: 'stu')
    @event = @user.events.create(description: 'party')
    @user.invite(@jen, @event)
    @user.invite(@stu, @event)
    @jen.attend(@event)
    @stu.attend(@event)
  end

  it 'shows an event' do
    visit(event_path(@event))
    expect(page).to have_current_path(event_path(@event))
    expect(page).to have_content('Attendees')

    @event.attendees.each do |attendee|
      expect(page).to have_content(attendee.name)
      expect(page).to have_selector("a[href=\"#{user_path(attendee)}\"]")
    end

    expect(page).to have_content('Creator')
    expect(page).to have_content(@event.creator.name)
    expect(page).to have_content('Description')
    expect(page).to have_content(@event.description)
    expect(page).to have_content('Date')
    expect(page).to have_content(@event.date.to_s)
  end

  it 'shows invitation form if user is the same' do
    visit(login_path)
    fill_in('Name', with: 'bob')
    find('input[type="submit"]').click
    visit(event_path(@event))
    expect(page).to have_current_path(event_path(@event))
    expect(page).to have_content('Attendees')

    @event.attendees.each do |attendee|
      expect(page).to have_content(attendee.name)
      expect(page).to have_selector("a[href=\"#{user_path(attendee)}\"]")
    end

    expect(page).to have_content('Creator')
    expect(page).to have_content(@event.creator.name)
    expect(page).to have_content('Description')
    expect(page).to have_content(@event.description)
    expect(page).to have_content('Date')
    expect(page).to have_content(@event.date.to_s)
    expect(page).to have_selector('form')
    expect(page).to have_selector('input')
    expect(page).to have_selector('input[type="submit"]')
  end
end
