class EventsController < ApplicationController
  before_action :redirect_if_not_signed_in
  before_action :set_event, only: [:show]
  before_action :create_event, only: [:new]

  def index
    @todays_events = Event.by_user(current_user).starts_today
    @upcoming_events = Event.by_user(current_user).upcoming_events
  end

  def create
    raise params.inspect
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
end
