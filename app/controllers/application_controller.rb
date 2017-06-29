class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :signed_in?
  helper_method :current_user

  def signed_in?
    !!current_user
  end

  def current_user
    # returns a dummy user until session controller is defined
    User.new
  end
end
