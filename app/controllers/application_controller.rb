class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user, :signed_in?

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def signed_in?
    !!current_user
  end

  def current_user=(user)
    @current_user = user
    session[:user_id] = user.id
  end
  
  def require_user
    unless current_user
      flash[:error] = "You must be logged in to access this page."
      redirect_to login_path
      return false
    end
  end
  
end
