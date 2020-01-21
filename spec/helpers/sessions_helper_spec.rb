require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the SessionsHelper. For example:
#
# describe SessionsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe SessionsHelper, type: :helper do
  before do
    @user = User.create(name: 'bob')
  end

  describe '#logged_in?' do
    it 'returns true if there is a user logged in' do
      controller.session[:user_id] = @user.id
      expect(helper.logged_in?).to be_truthy
    end

    it 'returns false if there is not a user logged in' do
      expect(helper.logged_in?).to be_falsy
    end
  end

  describe '#current_user' do
    it 'returns the user logged in' do
      controller.session[:user_id] = @user.id
      expect(helper.current_user).to eq(@user)
    end

    it 'returns nil if there is no user logged in' do
      expect(helper.current_user).to be_nil
    end
  end
end
