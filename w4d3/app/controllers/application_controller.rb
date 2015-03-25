class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  def login!(user)
    @current_user = user
    new_session = user.sessions.new
    new_session.save!
    session[:session_token] = new_session.session_token
  end

  def current_session
    return nil if session[:session_token].nil?

    @current_session ||= Session.find_by(
      session_token: session[:session_token]
    )
  end

  def current_user
    return nil if session[:session_token].nil?

    @current_user ||= current_session.try(:user)
  end

  def logout!
    current_session.destroy
    session[:session_token] = nil
  end

  def signed_in?
    !current_user.nil?
  end

  helper_method :current_user
  helper_method :signed_in?

end
