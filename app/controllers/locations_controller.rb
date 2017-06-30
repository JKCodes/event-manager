class LocationsController < ApplicationController
  before_action :redirect_if_not_signed_in

  def index
    @locations = Location.by_user(current_user)
  end
end
