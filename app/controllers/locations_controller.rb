class LocationsController < ApplicationController
  before_action :redirect_if_not_signed_in
  before_action :create_location

  def index
    @locations = Location.by_user(current_user)
  end

  def create
    @location = current_user.locations.build(location_params)

    if @location.save
      redirect_to locations_path, notice: "Location was created successfully"
    else
      render :new
    end
  end

  private
    def create_location
      @location = current_user.locations.build
    end

    def location_params
      params.require(:location).permit(:name, :street_address, :city, :state, :zipcode)
    end
end
