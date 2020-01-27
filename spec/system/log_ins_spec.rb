require 'rails_helper'

RSpec.describe 'LogIns', type: :system do
  before do
    driven_by(:selenium_chrome)
  end

  it 'logs in a user' do
    @user = User.create(name: 'bob')
    visit(login_path)
    fill_in('Name', with: 'bob')
    find('input[type="submit"]').click
    expect(page).to have_current_path('/')
    expect(page).to have_content('Logout')
    expect(page).to have_content('Create event')
    expect(page).to have_content(@user.name)
  end
end
