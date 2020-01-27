require 'rails_helper'

RSpec.describe 'SignUps', type: :system do
  before do
    driven_by(:selenium_chrome)
  end

  it 'signs up a user' do
    visit('/')
    click_link('Sign up')
    expect(page).to have_current_path(new_user_path)
    fill_in('Name', with: 'bob')
    count = User.count
    click_on('Create User')
    expect(User.count).to eq(count + 1)
    bob = User.find_by(name: 'bob')
    expect(bob).not_to be_nil
    expect(page).to have_current_path(user_path(bob))
  end
end
