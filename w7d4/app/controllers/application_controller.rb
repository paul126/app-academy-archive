class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user, :log_in!, :log_out!

  def current_user
    @current_user ||= User.find_by(session_token: session[:token])
  end

  def log_in!(user)
    session[:token] = user.reset_session_token!
  end

  def log_out!
    current_user.reset_session_token!
    @current_user = nil
    session[:token] = nil
  end

end
