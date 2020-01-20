require 'rails_helper'

RSpec.describe User, type: :model do
  context 'creating a user' do
    it 'creates a user' do
      expect { User.create(name: 'bob') }.not_to raise_error
    end
  end
end
