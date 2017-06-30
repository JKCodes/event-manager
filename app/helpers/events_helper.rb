module EventsHelper
  def formatted_time(time)
    time.strftime("%B %e, %Y - %l:%M %p")
  end

  def event_to_s(event)
    "#{event.name} (#{formatted_time(event.start_time)} ~ #{formatted_time(event.end_time)})"
  end
end
