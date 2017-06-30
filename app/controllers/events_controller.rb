class EventsController < ApplicationController
  before_action :redirect_if_not_signed_in
  before_action :set_event, only: [:show]
  before_action :create_event, only: [:new]

  def index
    @todays_events = Event.by_user(current_user).starts_today
    @upcoming_events = Event.by_user(current_user).upcoming_events
  end

  def create
    event = current_user.events.build(events_param)
    raise event.inspect
  end

  def new
    @event.build_location
  end

  private

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
