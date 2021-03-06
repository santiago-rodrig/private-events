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
    before do
      @user = User.create(name: 'bob')
      post :login, params: { name: 'bob' }
    end

    it 'sets the session[:user_id]' do
      expect(controller.session[:user_id]).to eq(@user.id)
    end

    it 'returns http redirect' do
      expect(response).to have_http_status(:redirect)
    end

    it 'redirects to root' do
      expect(response).to redirect_to(root_url)
    end
  end

  describe 'DELETE #logout' do
    before do
      @user = User.create(name: 'bob')
      post :login, params: { name: 'bob' }
      delete :logout
    end

    it 'clears the session[:user_id]' do
      expect(controller.session[:user_id]).to be_nil
    end

    it 'returns http redirect' do
      expect(response).to have_http_status(:redirect)
    end

    it 'redirects to root' do
      expect(response).to redirect_to(root_url)
    end
  end
end
