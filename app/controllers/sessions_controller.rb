class SessionsController < ApplicationController
  def new; end

  def login
    @user = User.find_by(name: params[:name])

    if @user
      redirect_to root_url
      session[:user_id] = @user.id
    else
      render :new
    end
  end

  def logout
    session.delete(:user_id)
    redirect_to root_url
  end
end
