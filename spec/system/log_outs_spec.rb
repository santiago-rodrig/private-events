require 'rails_helper'

RSpec.describe 'LogOuts', type: :system do
  before do
    driven_by(:selenium_chrome)
  end

  it 'logs out a user' do
    @user = User.create(name: 'bob')
    visit(login_path)
    fill_in('Name', with: 'bob')
    find('input[type="submit"]').click
    click_link('Logout')
    expect(page).not_to have_content(@user.name)
    expect(page).not_to have_content('Log out')
    expect(page).not_to have_content('Create event')
  end
end
