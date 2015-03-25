class SessionsController < ApplicationController

  def new
    @user = User.new
    render :new
  end

  def create
    user = User.find_by_credentials(params[:user][:email], params[:user][:password])

    if log_in!(user)
      redirect_to user_url(user)
    else
      @email = params[:user][:email]
      render :new
    end
  end

  def destroy
    log_out!
    redirect_to new_sessions_url
  end

end
