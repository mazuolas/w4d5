class SessionsController < ApplicationController
  def create
    @user = User.find_by_credentials(params[:user][:username], params[:user][:password])

    if @user
      login!(@user)
      redirect_to user_url(@user)
    else
      render :new
    end
  end

  def destroy
    @user = User.find_by(session_token: session[:session_token])
    @user.reset_session_token! # => resets user session token on DB
    session[:session_token] = nil # => clears cookie
    redirect_to users_url
  end
end
