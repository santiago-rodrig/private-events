class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to user_url(@user)
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    @attended_events = @user.attended_events
    @upcoming_attended_events = @user.upcoming_attended_events
    @past_attended_events = @user.past_attended_events
  end

  def invite
    @user = User.find(params[:id])
    @event = Event.find(params[:event_id])
    inviteds = params[:invitation][:users].strip.split(',').map { |e| e.strip }

    inviteds.each do |invited|
      user = User.find_by(name: invited)
      @user.invite(user, @event)
    end

    redirect_to event_url(@event)
  end

  def attend
    @user = User.find(params[:id])
    @event = Event.find(params[:event_id])

    unless !@event.inviteds.include?(@user)
      @user.attend(@event)
    end

    redirect_to user_url(@user)
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end
end
