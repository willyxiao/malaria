class WelcomeController < ApplicationController
  before_action :require_no_login, only: [:index, :signup]
  
  def index
  end

  def signup
  end

  def dashboard
  end

  private
  
  def require_no_login
    if not current_user.nil?
      redirect_to dashboard_url
    end
  end
end
