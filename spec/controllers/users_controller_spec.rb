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
    context 'valid data' do
      it "returns http redirect" do
        post :create
        expect(response).to have_http_status(:redirect)
      end
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show
      expect(response).to have_http_status(:success)
    end
  end

end
