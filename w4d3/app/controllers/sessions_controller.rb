class SessionsController < ApplicationController

   before_action :redirect_logged_in_user, only: [:new, :create]

  def redirect_logged_in_user
     if signed_in?
       flash[:notice] = "You are already logged in."
       redirect_to cats_url
     end
  end

  def new
    @user = User.new
    render :new
  end

  def create
    user = User.find_by_credentials(
      params[:user][:user_name],
      params[:user][:password]
    )

    if user.nil?
      redirect_to new_sessions_url
      flash[:notice] = "Invalid login."
    else
      login!(user)
      redirect_to cats_url
      flash[:notice] = "Successfully logged in."
    end
  end

  def destroy
    sess = Session.find(params[:id])
    if current_session == sess
      logout!
    else
      sess.destroy
    end
    redirect_to cats_url
  end

end
