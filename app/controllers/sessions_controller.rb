class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(env["omniauth.auth"])

    if user.community.nil? and session[:community_id]
      user.community_id = session[:community_id]
      user.save!
    elsif user.community.nil?
      @flash_message = "User is unregistered"
      redirect_to register_url
    end

    session[:user_id] = user.id
    redirect_to root_url
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
end
