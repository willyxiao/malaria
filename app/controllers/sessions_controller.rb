class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id

    if user.community.nil? and session[:community_id]
      user.community_id = session[:community_id]
      user.save!
    elsif user.community.nil?
      # TODO error handling
    end

    redirect_to root_url
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
end
