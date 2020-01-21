class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
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

  private

  def user_params
    params.require(:user).permit(:name)
  end
end
