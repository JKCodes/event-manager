class LocationsController < ApplicationController
  before_action :redirect_if_not_signed_in
  before_action :create_location, only: [:index, :new]
  before_action :set_location, only: [:show, :edit, :update, :destroy]
  before_action :set_locations, only: [:index]

  def create
    @location = current_user.locations.build(location_params)

    if @location.save
      redirect_to locations_path, notice: "Location was created successfully"
    else
      render :new
    end
  end

  def show
    set_previous_location(@location)
    set_next_location(@location)
    set_location_indexes(@location)
    if request.xhr? != 0
      render "show"
    else
      render json: @location
    end
  end

  def update
    if @location.update(location_params)
      redirect_to location_path(@location), notice: "Location was updated successfully"
    else
      render :edit
    end
  end

  def destroy
    @location.destroy
    redirect_to locations_path, notice: "Location and all its associated events are deleted successfully"
  end

  private
    def set_previous_location(location)
      @previous = Location.previous(location)
    end

    def set_next_location(location)
      @next = Location.next(location)
    end

    def set_location_indexes(location)
      @indexes = Location.indexes(location)
    end

    def set_locations
      @locations = Location.by_user(current_user)
    end

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
