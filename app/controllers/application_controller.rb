class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # before_action :require_logged_in

  private

  def current_user
    if session[:user_id] == 1
      @current_user ||= User.find_by(email: 'gzhang01@college.harvard.edu')
    else
      @current_user ||= User.find_registered(session[:user_id]) if session[:user_id]
    end
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
  
  helper_method :current_user
  helper_method :require_logged_in
  helper_method :require_logged_out
  helper_method :require_email
  
end
