class Api::SessionsController < ApplicationController

  def create
    user = User.find_by_credentials(user_params)
    if user
      log_in!(user)
      render :json => user
    else
      render :json => {errors: ["Invalid User and/or Password"]}, status: 422
    end

  end

  def destroy
    current_user.log_out!
    render :json => nil
  end

  private
    def user_params
      params.require(:user).permit(:username, :password)
    end

end
