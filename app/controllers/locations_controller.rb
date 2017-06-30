class LocationsController < ApplicationController
  before_action :redirect_if_not_signed_in
  before_action :create_location

  def index
    @locations = Location.by_user(current_user)
  end

  private
    def create_location
      @location = current_user.locations.build
    end
end
