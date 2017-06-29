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
    @user = User.new(session_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Welcome to Event Manager!"
    else
      render :signup
    end
  end

  def destroy
    session.delete :user_id
    redirect_to root_path
  end

  private
    def session_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end
end
