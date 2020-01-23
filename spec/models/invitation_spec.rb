require 'rails_helper'

RSpec.describe Invitation, type: :model do
  before do
    @user = User.create(name: 'bob')
    @other_user = User.create(name: 'jen')

    @event = @other_user.events.create(
      description: 'party'
    )

    @invitation = Invitation.create(
      invited_id: @user.id, inviting_event_id: @event.id
    )
  end

  it 'belongs to an invited' do
    expect(@invitation).to be_respond_to(:invited)
    expect(@invitation.invited).to eq(@user)
  end

  it 'belongs to an inviting_event' do
    expect(@invitation).to be_respond_to(:inviting_event)
    expect(@invitation.inviting_event).to eq(@event)
  end
end
