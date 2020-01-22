require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'POST #invite' do
    before do
      @user = User.create(name: 'bob')
      @other_user = User.create(name: 'lana')
      @another_user = User.create(name: 'stuart')
      @event = @user.events.create(description: 'party')

      post(
        :invite,
        params: {
          id: @user.id,
          event_id: @event.id,
          invitation: {
            users: 'lana, stuart'
          }
        }
      )
    end

    it 'invites the users' do
      expect(@event.inviteds).to include(@other_user)
      expect(@event.inviteds).to include(@another_user)
      expect(@event.inviteds.count).to eq(2)
      expect(@other_user.inviting_events).to include(@event)
      expect(@another_user.inviting_events).to include(@event)
      expect(@other_user.inviting_events.count).to eq(1)
      expect(@another_user.inviting_events.count).to eq(1)
    end

    it 'redirects to show' do
      expect(response).to redirect_to(user_url(@user))
    end
  end

  describe 'POST #attend' do
    before do
      @user = User.create(name: 'bob')
      @other_user = User.create(name: 'lana')
      @another_user = User.create(name: 'stuart')
      @event = @user.events.create(description: 'party')

      post(
        :invite,
        params: {
          id: @user.id,
          event_id: @event.id,
          invitation: {
            users: 'lana, stuart'
          }
        }
      )
    end

    context 'the user is not invited' do
      before do
        @not_invited = User.create(name: 'gabriel')

        post(
          :attend,
          params: {
            id: @not_invited.id,
            event_id: @event.id
          }
        )
      end

      it 'can not attend the event' do
        expect(@not_invited.attended_events).not_to include(@event)
        expect(@event.attendees).not_to include(@not_invited)
      end

      it 'redirects to show' do
        expect(response).to redirect_to(user_url(@not_invited))
      end
    end

    context 'the user is invited' do
      before do
        post(
          :attend,
          params: {
            id: @other_user.id,
            event_id: @event.id
          }
        )
      end

      it 'can attend the event' do
        expect(@other_user.attended_events).to include(@event)
        expect(@event.attendees).to include(@other_user)
      end

      it 'redirects to show' do
        expect(response).to redirect_to(user_url(@other_user))
      end
    end
  end

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
