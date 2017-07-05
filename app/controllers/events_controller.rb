class EventsController < ApplicationController
  before_action :redirect_if_not_signed_in
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :create_event, only: [:new]
  before_action :set_location, except: [:destroy]
  before_action :set_participant, only: [:index]

  def index
    if params[:location_id]
      @todays_events = Location.by_user(current_user).find(params[:location_id]).events.starts_today
      @upcoming_events = Location.by_user(current_user).find(params[:location_id]).events.upcoming_events
      @old_events = Location.by_user(current_user).find(params[:location_id]).events.old_events
    elsif params[:participant_id]
      @todays_events = Participant.by_user(current_user).find(params[:participant_id]).events.starts_today
      @upcoming_events = Participant.by_user(current_user).find(params[:participant_id]).events.upcoming_events
      @old_events = Participant.by_user(current_user).find(params[:participant_id]).events.old_events
    else
      @todays_events = Event.by_user(current_user).starts_today
      @upcoming_events = Event.by_user(current_user).upcoming_events
      @old_events = Event.by_user(current_user).old_events
    end
  end

  def create
    create_params = events_param
    create_params[:user_id] = session[:user_id]
    @event = Event.new(create_params)
    if @event.save
      redirect_to @location ? location_events_path : events_path
    else
      render :new
    end
  end

  def new
    @event = Event.new(location_id: params[:location_id]) if params[:location_id]
  end

  def show
  end

  def update
    if @event.update(events_param)
      redirect_to @location ? location_event_path(@location) : event_path(@event), notice: "Event was updated successfully!"
    else
      render :edit
    end
  end

  def destroy
    @event.destroy
    redirect_to events_path, notice: "Event was deleted successfully."
  end

  private
    def set_location
      @location = Location.by_user(current_user).find(params[:location_id]) if params[:location_id]
    end

    def set_participant
      @participant = Participant.by_user(current_user).find(params[:participant_id]) if params[:participant_id]
    end

    def set_event
      @event = Event.by_user(current_user).find(params[:id])
    end

    def create_event
      @event = current_user.events.build
    end

    def events_param
      params.require(:event).permit(:name, :start_time, :end_time, :location_id, participant_ids: [], location_attributes: [:name], participants_attributes: [:nickname])
    end
end
