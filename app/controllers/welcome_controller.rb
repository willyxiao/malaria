class WelcomeController < ApplicationController
  def index
    if not current_user.nil?
      redirect_to dashboard_url
    end
  end

  def dashboard
  end
end
