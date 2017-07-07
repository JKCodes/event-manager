$(document).on('turbolinks:load', function() {

  $("a.load_previous").on("click", function(e) {
    e.preventDefault();

  });

  $("a.load_next").on("click", function(e) {
    e.preventDefault();

  });  

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
