require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe 'GET #new' do
    before do
      get :new
    end

    it 'returns HTTP success' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #login' do
  end

  describe 'DELETE #logout' do
  end
end
