module EventsHelper
  def formatted_time(time)
    time.strftime("%B %e, %Y - %l:%M %p")
  end
end
