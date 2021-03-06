require 'rails_helper'

RSpec.describe 'events/show.html.erb', type: :view do
  before do
    @user = User.create(name: 'bob')
    @stu = User.create(name: 'stu')
    @jen = User.create(name: 'jen')
    @event = @user.events.create(description: 'party')
    @event.attendees << @stu
    @event.attendees << @jen
    @attendees = @event.attendees
    assign(:event, @event)
    assign(:attendees, @attendees)
  end

  it 'displays the description of the event' do
    render
    expect(rendered).to match(
      Regexp.new(
        ".*<h2>Description</h2>.*#{@event.description}.*",
        1 | 4
      )
    )
  end

  it 'displays the date of the event' do
    render
    expect(rendered).to match(
      Regexp.new(
        ".*<h2>Date</h2>.*#{@event.date}.*",
        1 | 4
      )
    )
  end

  it 'displays the creator of the event' do
    render
    expect(rendered).to match(
      Regexp.new(
        ".*<h2>Creator</h2>.*#{@event.creator.name}.*<a.*href=\"#{user_path(@event.creator)}\".*>Show</a>.*",
        1 | 4
      )
    )
  end

  it 'displays a list of attendees' do
    render
    @attendees.each do |attendee|
      expect(rendered).to match(
        Regexp.new(
          ".*<h2>Attendees</h2>.*#{attendee.name}.*<a.*href=\"#{user_path(attendee)}\".*>Show</a>.*",
          1 | 4
        )
      )
    end
  end

  # rubocop:disable Metrics/BlockLength
  context 'invitations' do
    context 'logged user is owner of the event' do
      before do
        controller.session[:user_id] = @user.id
      end

      it 'displays a form pointing to users/:id/invite' do
        render
        expect(rendered).to match(
          Regexp.new(
            ".*<form.*action=\"#{invite_user_path(@event.creator)}\".*>.*</form>",
            1 | 4
          )
        )
      end

      it 'displays a text field for inviteds' do
        render
        expect(rendered).to match(
          Regexp.new(
            ".*<form.*>.*<input.*[(name=\"invitation\[users\]\")(type=\"text\")].*>.*</form>.*",
            1 | 4
          )
        )
      end

      it 'displays a submit button' do
        render
        expect(rendered).to match(
          %r{.*<form.*>.*<input.*type="submit".*>.*</form>}mi
        )
      end
    end

    context 'the logged user is not the owner of the event' do
      before do
        controller.session[:user_id] = @stu.id
      end

      it 'does not display a form pointing to users/:id/invite' do
        render
        expect(rendered).not_to match(
          Regexp.new(
            ".*<form.*action=\"#{invite_user_path(@event.creator)}\".*>.*</form>",
            1 | 4
          )
        )
      end

      it 'does not display a text field for inviteds' do
        render
        expect(rendered).not_to match(
          Regexp.new(
            ".*<form.*>.*<input.*[(name=\"invitation\[users\]\")(type=\"text\")].*>.*</form>.*",
            1 | 4
          )
        )
      end

      it 'does not display a submit button' do
        render
        expect(rendered).not_to match(
          %r{.*<form.*>.*<input.*type="submit".*>.*</form>}mi
        )
      end
    end

    context 'there is not a logged in user' do
      it 'does not display a form pointing to users/:id/invite' do
        render
        expect(rendered).not_to match(
          Regexp.new(
            ".*<form.*action=\"#{invite_user_path(@event.creator)}\".*>.*</form>",
            1 | 4
          )
        )
      end

      it 'does not display a text field for inviteds' do
        render
        expect(rendered).not_to match(
          Regexp.new(
            ".*<form.*>.*<input.*[(name=\"invitation\[users\]\")(type=\"text\")].*>.*</form>.*",
            1 | 4
          )
        )
      end

      it 'does not display a submit button' do
        render
        expect(rendered).not_to match(
          %r{.*<form.*>.*<input.*type="submit".*>.*</form>}mi
        )
      end
    end
  end
  # rubocop:enable Metrics/BlockLength
end
