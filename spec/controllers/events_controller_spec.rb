require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  before do
    @user = User.create(name: 'bob')
    @event = @user.events.create(name: 'party', date: (Time.now + 3600).to_date)
    @user.events.create(name: 'beach party', date: (Time.now + 3600).to_date)
    @user.events.create(name: 'birthday party', date: (Time.now + 3600).to_date)
  end

  describe 'GET #show' do
    before do
      get :show, params: { id: @event.id }
    end

    it 'sets the correct event' do
      expect(assigns(:event)).to eq(@event)
    end

    it 'renders the correct template' do
      expect(response).to render_template(:show)
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #index' do
  end

  describe 'POST #create' do
  end

  describe 'GET #new' do
  end
end
