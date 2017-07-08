$(document).on('turbolinks:load', function() {

  $("#new_location").on('submit', function(e) {
    e.preventDefault();
    
  });

  $("a.load_next, a.load_previous").on("click", function(e) {
    e.preventDefault();

    const indexes = $(this).data("indexes")
    const current_id = +$(this).attr("data-current")
    const current_index = indexes.indexOf(current_id)
    var modified_index = $(this).attr('class') === "load_next" ? current_index + 1 : current_index - 1
    if (modified_index >= indexes.length) { modified_index = 0; }
    if (modified_index < 0) { modified_index = indexes.length - 1; }
    const previous_index = modified_index > 0 ? modified_index - 1 : indexes.length - 1
    const next_index = modified_index < indexes.length - 1 ? modified_index + 1 : 0
    const previous_id = indexes[previous_index]
    const next_id = indexes[next_index]

    $.get(this.href).success(function(json) {
      $("div.location_events").hide()
      $("a.load_previous")[0].href = "/locations/" + previous_id
      $("a.load_next")[0].href = "/locations/" + next_id
      $("a.load_previous").attr("data-current", json.id)
      $("a.load_next").attr("data-current", json.id)
      $("#name").html("Name: " + json.name)
      $("#street_address").html("Street Address: " + json.street_address)
      $("#city").html("City: " + json.city)
      $("#state").html("State: " + json.state)
      $("#zipcode").html("Zipcode: " + json.zipcode)
    });
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
