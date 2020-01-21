class SessionsController < ApplicationController
  def new; end

  def login
    @user = User.find_by(name: params[:name])

    if @user
      session[:user_id] = @user.id
    else
      render :new
    end
  end
end
