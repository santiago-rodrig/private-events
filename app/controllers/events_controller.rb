class EventsController < ApplicationController
  def show
    @event = Event.find(params[:id])
  end

  def index
    @events = Event.all
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
    params.require(:event).permit(:name, :date)
  end
end
