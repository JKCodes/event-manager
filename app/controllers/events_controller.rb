class EventsController < ApplicationController
  before_action :redirect_if_not_signed_in
  before_action :set_event, only: [:show]

  def index
    @todays_events = Event.by_user(current_user).starts_today
    @upcoming_events = Event.by_user(current_user).upcoming_events
  end

  private
    def set_event
      @event = Event.find(params[:id])
    end
end
