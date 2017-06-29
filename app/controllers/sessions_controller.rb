class SessionsController < ApplicationController
  before_action :create_user, only: [:signin, :signup]

  def signin_post
    user = User.find_by(username: params[:user][:username])
    if user && user.authenticate(params[:user][:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: "Welcome back to Event Manager!"
    else
      @user = User.new(session_params)
      @user.valid?
      @user.errors.delete :email
      @user.errors.delete :username if user
      @user.errors.add(:base, "Username/password combination not found") if params[:user][:password].length >= 8 && @user.errors.empty?
  
      render :signin
    end
  end

  def signup_post
    user = User.new(session_params)
    if user.save
      session[:user_id] = user.id
      redirect_to root_path, notice: "Welcome to Event Manager!"
    else
      @user = user
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

    def create_user
      @user = User.new
    end
end
