class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :signed_in?
  helper_method :current_user

  def signed_in?
    !!current_user
  end

  def current_user
    User.find_by(id: session[:user_id])
  end

  def redirect_if_signed_in
    redirect_to root_path, notice: "You are already signed in!" if signed_in?
  end

  def redirect_if_not_signed_in
    redirect_to signin_path, notice: "You must be signed in to access this page." if !signed_in?
  end
end
