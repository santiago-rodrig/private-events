class EventsController < ApplicationController
  def new
    @event = Event.new
  end

  def show
    @event = Event.find(params[:id])
    @attendees = @event.attendees
  end

  def index
    @events = Event.all
    @past_events = Event.past
    @future_events = Event.future
  end

  def create
    @user = User.find(session[:user_id])
    @event = @user.events.build(event_params)

    if @event.save
      redirect_to event_url(@event)
    else
      render :new
    end
  end

  private

  def event_params
    params.require(:event).permit(:description)
  end
end
