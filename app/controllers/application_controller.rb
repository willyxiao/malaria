class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # before_action :require_logged_in

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
  
  helper_method :current_user
  helper_method :require_logged_in
  helper_method :require_logged_out
  helper_method :require_email
  
end
