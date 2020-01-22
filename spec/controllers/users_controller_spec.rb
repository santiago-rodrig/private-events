require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #new' do
    before do
      get :new
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'sets a user variable' do
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe 'POST #create' do
    before do
      post :create, params: { user: { name: 'bob' } }
      @user = assigns(:user)
    end

    it 'returns http redirect' do
      expect(response).to have_http_status(:redirect)
    end

    it 'redirects to the user show page' do
      expect(response).to redirect_to(user_url(@user))
    end

    it 'creates a new user' do
      count = User.count
      post :create, params: { user: { name: 'gabriel' } }
      expect(User.count).to eq(count + 1)
    end

    it 'logins the new user' do
      expect(controller.session[:user_id]).to eq(@user.id)
    end
  end

  describe 'GET #show' do
    before do
      @user = User.create(name: 'lenny')
      get :show, params: { id: @user.id }
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'sets the corresponding user' do
      expect(assigns(:user)).to eq(@user)
    end

    it 'sets attended_events variable' do
      expect(assigns(:attended_events)).to eq(@user.attended_events)
    end

    it 'sets upcoming_attended_events variable' do
      expect(assigns(:upcoming_attended_events)).to eq(@user.upcoming_attended_events)
    end

    it 'sets past_attended_events variable' do
      expect(assigns(:past_attended_events)).to eq(@user.past_attended_events)
    end
  end
end
