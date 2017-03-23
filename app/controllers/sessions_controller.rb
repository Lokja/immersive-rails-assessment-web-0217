class SessionsController < ApplicationController

  def new
    if logged_in
      @user = User.find(logged_in)
      redirect_to guests_path
    else
      @user = User.new
    end
  end

  def create
    @user = User.find_by(username: session_params[:username])
    if @user
      if @user.authenticate(session_params[:password])
        session[:user_id] = @user.id
        redirect_to guests_path
      end
    else
      redirect_to login_path
    end
  end

  private

  def logged_in
    @user = session[:account_id]
  end

  def session_params
    params.require(:user).permit(:username, :password)
  end

end
