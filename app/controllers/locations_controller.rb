class LocationsController < ApplicationController
  before_action :redirect_if_not_signed_in
  before_action :create_location, only: [:new]
  before_action :set_location, only: [:show, :edit, :update, :destroy]

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

  def update
    if @location.update(location_params)
      redirect_to location_path(@location), notice: "Location was updated successfully"
    else
      render :edit
    end
  end

  private
    def create_location
      @location = current_user.locations.build
    end

    def set_location
      @location = Location.by_user(current_user).find(params[:id])
    end

    def location_params
      params.require(:location).permit(:name, :street_address, :city, :state, :zipcode)
    end
end
