class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(env["omniauth.auth"])

    if user.community.nil? and session[:community_id]
      if not Game.find_by(community_id: session[:community_id]).nil?
        @flash_message = "This community has already started a game, cannot register"
        redirect_to register_url and return 
      end
      user.community_id = session[:community_id]
      user.save!
    elsif user.community.nil?
      @flash_message = "User is unregistered"
      redirect_to register_url and return 
    end

    session[:user_id] = user.id
    redirect_to root_url and return
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url and return
  end
end
