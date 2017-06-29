class SessionsController < ApplicationController
  def signin
    @user = User.new
  end

  def signin_post
    user = User.find_by(username: params[:user][:username])
    if user && user.authenticate(params[:user][:password])
      session[:user_id] = user.user
      redirect_to root_path, notice: "Welcome back to Event Manager!"
    else
      redirect_to signin_path
    end
  end

  def signup
    @user = User.new
  end

  def signup_post

  end

  def destroy
    session.delete :user_id
    redirect_to root_path
  end

  private
    def session_params
      params.require(:user).permit(:username, :password, :password_confirmation)
    end
end
