$(document).on('turbolinks:load', function() {

  // Location show events
  $("a.load_events").on("click", function(e) {
    e.preventDefault();

    $.get(this.href).success(function(json) {
      $("a.load_events").hide()

      var $events = $("div.events")
      var html = "<ol>"

      json.forEach(function(event) {
        html += `<li><a href="/events/${event.id}">${event.name}</a></li>`
      })

      html += "</ol>"

      $events.html(html)
    });
  });  
});
