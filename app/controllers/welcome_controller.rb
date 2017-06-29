class WelcomeController < ApplicationController
  before_action :redirect_if_signed_in
  def home
  end
end
