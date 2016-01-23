class WelcomeController < ApplicationController
  before_action :require_no_login, only: [:index, :signup]
  
  def index
  end

  def register
  end

  def register_hash
    redirect register_url + "#/#{ params[:hash] }"
  end
  
  def dashboard
  end
  
  def rules
  end

  private
  
  def require_no_login
    if not current_user.nil?
      redirect_to dashboard_url
    end
  end
end
