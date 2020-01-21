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
    before do
      get :index
    end

    it 'sets the events variable to all events' do
      expect(assigns(:events)).to eq(Event.all)
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders the correct template' do
      expect(response).to render_template(:index)
    end

    it 'displays the three events' do
      expect(assigns(:events).count).to eq(3)
    end
  end

  describe 'POST #create' do
    before do
      @user = User.create(name: 'bob')
      controller.session[:user_id] = @user.id

      post(
        :create,
        params: {
          event: { name: 'party', date: (Time.now + 3600).to_date }
        }
      )
    end

    it 'creates a new event' do
      count = Event.count

      post(
        :create,
        params: {
          event: { name: 'beach party', date: (Time.now + 3600).to_date }
        }
      )

      expect(Event.count).to eq(count + 1)
    end

    it 'belongs to the current user' do
      event = Event.last
      expect(event.creator).to eq(@user)
    end

    it 'returns http redirect' do
      expect(response).to have_http_status(:redirect)
    end
  end

  describe 'GET #new' do
  end
end
