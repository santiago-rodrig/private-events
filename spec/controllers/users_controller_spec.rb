require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "GET #new" do
    before do
      get :new
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it 'sets a user variable' do
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe "POST #create" do
    before do
      post :create, params: { user: { name: 'bob' } }
      @user = assigns(:user)
    end

    it "returns http redirect" do
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
  end

  describe "GET #show" do
    before do
      @user = User.create(name: 'lenny')
      get :show, params: { id: @user.id }
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it 'sets the corresponding user' do
      expect(assigns(:user)).to eq(@user)
    end

    it 'sets a attended_events variable' do
      expect(assigns(:attended_events)).to eq(@user.attended_events)
    end
  end

end
