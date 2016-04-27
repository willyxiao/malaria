class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def current_user
    @current_user ||= User.find_registered(session[:user_id]) if session[:user_id]
  end
  
  def logged_in?
    not current_user.nil?
  end
  
  def require_logged_in
    if not logged_in?
      # TODO make this login once registration phase is over
      redirect_to register_url
    end
  end
  
  def require_logged_out
    if logged_in?
      redirect_to root_url
    end
  end
  
  def require_email
    if not current_user.email
      redirect_to email_url
    end
  end

  def require_confirmed_email
    if not user_confirmed_email?
      redirect_to root_url
    end
  end
  
  def user_confirmed_email?
    (not current_user.email.nil?) and current_user.confirmed_email
  end
  
  def get_stats
    {
        users: User.count,
        active: Player.count,
        alive: Player.where.not(target_id: nil).count,
        communities: Community.count - 2, # there are two test houses
        malariafactviews: Malariafactview.count,
        questions: Malariafactview.joins(:malariafact).where('malariafacts.fact_type': Malariafact.fact_types[:question]).count,
      }
  end
  
  helper_method :current_user
  helper_method :require_logged_in
  helper_method :require_logged_out
  helper_method :require_email
  
end
