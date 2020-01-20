require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it 'sets a user variable' do
      get :new
      user = assigns(:user)
      expect(user).not_to be_nil
    end
  end

  describe "POST #create" do
    before do
      post :create, params: { user: { name: 'bob' } }
    end

    context 'valid data' do
      it "returns http redirect" do
        expect(response).to have_http_status(:redirect)
      end

      it 'creates a new user' do
        count = User.count
        post :create, params: { user: { name: 'gabriel' } }
        expect(User.count).to eq(count + 1)
      end
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
  end

end
