class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?, :current_band, :current_album, :current_track, :ugly_lyrics

  def log_in!(user)
    return nil if user.nil?
    session[:session_token] = user.session_token
  end

  def log_out!
    current_user.reset_session_token!
    session[:session_token] = nil
  end

  def logged_in?
    !current_user.nil?
  end

  def current_user
    user = User.find_by(session_token: session[:session_token])
    user.nil? ? nil : user
  end

  def require_login_to_view
    redirect_to new_sessions_url unless logged_in?
  end

  def current_band
    return nil if @album.nil? && (@track.nil? || @track.album_id.nil?)
    return @album.band if @track.nil?
    @track.album.band
  end

  def current_album
    return nil if @track.nil?
    @track.album
  end

  def current_track
    return nil if @track.nil?
    @track
  end

  def ugly_lyrics(lyrics)
    lyrics.split("\n")
  end



end
