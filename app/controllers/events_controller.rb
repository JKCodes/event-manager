class EventsController < ApplicationController
  before_action :redirect_if_not_signed_in

  def index
    @todays_events = Event.by_user(current_user).starts_today
    @upcoming_events = Event.by_user(current_user).upcoming_events
  end
end
