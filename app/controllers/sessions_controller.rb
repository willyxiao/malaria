class SessionsController < ApplicationController
  # create user once logged in
  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    flash[:info] = 'Successfully signed in'
    
    # redirect to welcome page
    redirect_to root_url
  end

  # sign out user from database
  def destroy
    session[:user_id] = nil
    flash[:info] = 'Successfully signed out!'
    
    # redirect to welcome page
    redirect_to root_url
  end
end
